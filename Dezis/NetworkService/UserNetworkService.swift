import UIKit
import Moya

struct UserRegisterResponse: Decodable {
    let id: Int?
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
    let tokens: ClientTokens
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case detail
        case tokens
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
    let isConfirmed: Bool
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, username, email, password, address, number, avatar
        case apartmentNumber = "apartment_number"
        case isConfirmed = "is_confirmed"
        case createdAt = "created_at"
    }
}

struct ClientOrder: Decodable {
    let id: Int
    let user: Int
    let date: String
    let time: String
    let service: String
    let isFirstProcessing: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, user, date, time, service
        case isFirstProcessing = "is_first_processing"
    }
}

extension ClientOrder {
    func dateTime() -> Date? {
        let dateTimeString = "\(date) \(time)"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = formatter.date(from: dateTimeString) {
            return date
        } else {
            print("Ошибка преобразования для строки: \(dateTimeString)")
            return nil
        }
    }
}

struct ErrorResponse: Codable {
    let message: String
    let email: String
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
                                    
                                  
                    let tokens = UserTokenResponseModel(accessToken: registerResponse.tokens.access,
refreshToken: registerResponse.tokens.refresh)
                    KeychainService.shared.saveToken(token: tokens)
                  
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
                    let userTokenResponseModel = UserTokenResponseModel(accessToken: userResponse.tokens.access, refreshToken: userResponse.tokens.refresh)
                    KeychainService.shared.saveToken(token: userTokenResponseModel)
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
    
    func fetchClientOrders(clientId: Int, completion: @escaping (Result<[ClientOrder], Error>) -> Void) {
        provider.request(.fetchProcessingOrders(clientId: clientId)) { result in
            switch result {
            case .success(let response):
                self.logResponse(response)
                
                do {
                    let orders = try JSONDecoder().decode([ClientOrder].self, from: response.data)
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
    
    func forgotPassword(email: String, completion: @escaping (Result<Int, Error>) -> Void) {
        provider.request(.forgotPassword(email: email)) { result in
            switch result {
            case .success(let response):
                self.logResponse(response)
                
                if response.statusCode == 404 {
                    let message = "Указанный адрес электронной почты не найден. Пожалуйста, проверьте правильность введенных данных или зарегистрируйтесь."
                    completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: message])))
                    return
                }
                
                if response.statusCode == 400 {
                    let message = "Указанный адрес электронной почты не найден. Пожалуйста, проверьте правильность введенных данных или зарегистрируйтесь."
                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: message])))
                    return
                }
                
                if response.statusCode == 200 {
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                        if let userId = json?["user_id"] as? Int {
                            completion(.success(userId))
                        } else {
                            completion(.failure(NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "User ID не найден"])))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                    return
                }
                
                completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateUserPassword(userId: Int, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let parameters: [String: Any] = [
            "password": newPassword,
            "is_confirmed": true
        ]
        
        provider.request(.updateUserInfo(userId: userId, parameters: parameters)) { result in
            switch result {
            case .success(let response):
                self.logResponse(response)
                
                guard (200...299).contains(response.statusCode) else {
                    completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                    return
                }
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func updateUserNumber(userId: Int, newNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let parameters: [String: Any] = [
            "number": newNumber,
            "is_confirmed": true
        ]
        
        provider.request(.updateUserInfo(userId: userId, parameters: parameters)) { result in
            switch result {
            case .success(let response):
                self.logResponse(response)
                
                guard (200...299).contains(response.statusCode) else {
                    completion(.failure(self.decodeError(from: response.data, statusCode: response.statusCode)))
                    return
                }
                completion(.success(()))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


