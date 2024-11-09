import UIKit
import Moya

struct UserRegisterResponse: Decodable {
    let id: Int
    let detail: Detail
    let tokens: ClientTokens

    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case detail, tokens
    }
}

struct Detail: Decodable {
    let detail: String
}

struct ClientTokens: Decodable {
    let refresh: String
    let access: String
}

struct UserLoginResponse: Decodable {
    let detail: String
    let id: Int
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case detail
    }
}
struct UserLogOutResponse: Decodable {
    let id: Int
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case detail
    }
}
struct ResendOtpResponse: Decodable {
    let detail: String
}

struct UserVerifyResponse: Decodable {
    let detail: String
}

struct BookingLoginResponse: Decodable {
    let id: Int
    let user: Int
    let service: String
    let date: String
    let time: String
    let isCompleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, user, service, date, time
        case isCompleted = "is_completed"
    }
}

struct UserProfile: Decodable {
    let id: Int?
    let username: String?
    let email: String
    let apartmentNumber: String?
    let password: String
    let address: String?
    let number: String
    let avatar: String?
    let isActive: Bool
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, username, email, password, address, number, avatar
        case apartmentNumber = "apartment_number"
        case isActive = "is_active"
        case createdAt = "created_at"
    }
}


struct ErrorResponse: Codable {
    let message: String
}

enum LoginError: Error {
    case invalidCredentials
    case serverError(message: String)
}

    class UserNetworkService {
        
        private let keychain = KeychainService()
        private let provider = MoyaProvider<UserApi>()
        
        private func decodeError(from data: Data, statusCode: Int) -> Error {
            do {
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                return NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
            } catch {
                return error
            }
        }
        
        private func logResponse(_ response: Response) {
            print("Response status code: \(response.statusCode)")
            let jsonString = String(data: response.data, encoding: .utf8) ?? "Нет данных"
            print("Полученные данные: \(jsonString)")
        }
        
        func userRegister(username: String, email: String, number: String, password: String, apartmentNumber: String, address: String, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
            provider.request(.userRegister(username: username, email: email, number: number, password: password, apartmentNumber: apartmentNumber, address: address)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    
                    do {
                        guard (200...299).contains(response.statusCode) else {
                            completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                            return
                        }
                        
                        let registerResponse = try JSONDecoder().decode(UserRegisterResponse.self, from: response.data)
                        completion(.success(registerResponse))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        func verifyUser(email: String, otp: String, completion: @escaping (Result<UserVerifyResponse, Error>) -> Void) {
            provider.request(.verifyUser(email: email, otp: otp)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    
                    do {
                        guard (200...299).contains(response.statusCode) else {
                            completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                            return
                        }
                        
                        let userResponse = try JSONDecoder().decode(UserVerifyResponse.self, from: response.data)
                        completion(.success(userResponse))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        func userLogin(email: String, password: String, completion: @escaping (Result<UserLoginResponse, Error>) -> Void) {
            provider.request(.userLogin(email: email, password: password)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    
                    do {
                        guard (200...299).contains(response.statusCode) else {
                            completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                            return
                        }
                        
                        let userResponse = try JSONDecoder().decode(UserLoginResponse.self, from: response.data)
                        completion(.success(userResponse))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        func booking(user: Int, service: String, date: String, time: String, isCompleted: Bool, completion: @escaping (Result<BookingLoginResponse, Error>) -> Void) {
            provider.request(.booking(user: user, service: service, date: date, time: time, is_completed: isCompleted)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    
                    do {
                        guard (200...299).contains(response.statusCode) else {
                            completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                            return
                        }
                        
                        let userResponse = try JSONDecoder().decode(BookingLoginResponse.self, from: response.data)
                        completion(.success(userResponse))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        func fetchUser(id: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
            provider.request(.userDetails(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                       
                        if let jsonString = String(data: response.data, encoding: .utf8) {
                            print("Received JSON response: \(jsonString)")
                        }
                        
                    
                        let users = try JSONDecoder().decode([UserProfile].self, from: response.data)
                        
                        if let user = users.first {
                            completion(.success(user))
                        } else {
                            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                        }
                        
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("Ошибка сети: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        
        
        
        func getUserProfile(email: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
            provider.request(.getUserProfile(email: email)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    
                    do {
                        let users = try JSONDecoder().decode([UserProfile].self, from: response.data)
                        
                        if let user = users.first(where: { $0.email.lowercased() == email.lowercased() }) {
                            completion(.success(user))
                        } else {
                            let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Пользователь с таким email не найден"])
                            completion(.failure(error))
                        }
                        
                    } catch let decodingError {
                        
                        print("Ошибка декодирования UserProfile: \(decodingError)")
                        completion(.failure(decodingError))
                    }
                    
                case .failure(let networkError):
                    
                    print("Ошибка сети: \(networkError.localizedDescription)")
                    completion(.failure(networkError))
                }
            }
        }
        
        func fetchClientOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
            provider.request(.fetchClientOrders) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    
                    do {
                        let orders = try JSONDecoder().decode([Order].self, from: response.data)
                        completion(.success(orders))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("Ошибка сети: \(error)")
                    completion(.failure(error))
                }
            }
        }
        
        func userDetails(id: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
            provider.request(.userDetails(id: id)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    
                    do {
                        let users = try JSONDecoder().decode([UserProfile].self, from: response.data)
                        
                        if let user = users.first {
                            completion(.success(user))
                        } else {
                            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                        }
                        
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    print("Ошибка сети: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        
        func logOut(email: String, completion: @escaping (Result<UserLogOutResponse, Error>) -> Void) {
            provider.request(.logOut(email: email)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    do {
                        guard (200...299).contains(response.statusCode) else {
                            completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                            return
                        }
                        
                        let userResponse = try JSONDecoder().decode(UserLogOutResponse.self, from: response.data)
                        completion(.success(userResponse))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        func resendOtp(email: String, completion: @escaping (Result<ResendOtpResponse, Error>) -> Void) {
            provider.request(.resendOtp(email: email)) { result in
                switch result {
                case .success(let response):
                    self.logResponse(response)
                    do {
                        guard (200...299).contains(response.statusCode) else {
                            completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                            return
                        }
                        
                        let otpResponse = try JSONDecoder().decode(ResendOtpResponse.self, from: response.data)
                        completion(.success(otpResponse))
                    } catch {
                        print("Ошибка декодирования: \(error)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }


