import UIKit
import Moya

struct UserRegisterResponse: Codable {
    let detail: String
    let id: Int?
    let email: String?
}

struct UserLoginResponse: Decodable {
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
    let is_completed: Bool
}
struct UserProfile: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let avatarURL: String
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
    
    func userRegister(username: String, email: String, password: String, apartmentNumber: String, address: String, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
        provider.request(.userRegister(username: username, email: email, password: password, apartmentNumber: apartmentNumber, address: address)) { result in
            switch result {
            case .success(let response):
                print("Response status code: \(response.statusCode)")
                let jsonString = String(data: response.data, encoding: .utf8) ?? "Нет данных"
                print("Полученные данные: \(jsonString)")
                
                do {
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])))
                        return
                    }
                    
                    let registerResponse = try JSONDecoder().decode(UserRegisterResponse.self, from: response.data)
                    print("User ID: \(String(describing: registerResponse.id))")
                    print("Email: \(String(describing: registerResponse.email))")
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
    func verifyUser(email: String, otp: String, completion: @escaping ((Result<UserVerifyResponse, Error>) -> Void)) {
        provider.request(.verifyUser(email: email, otp: otp)) { result in
            switch result {
            case .success(let response):
                print("Response status code: \(response.statusCode)")
                let jsonString = String(data: response.data, encoding: .utf8) ?? "Нет данных"
                print("Полученные данные: \(jsonString)")
                do {
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self,from: response.data)
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])))
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
                print("Response status code: \(response.statusCode)")
                let jsonString = String(data: response.data, encoding: .utf8) ?? "Нет данных"
                print("Полученные данные: \(jsonString)")
                
                do {
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])))
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


func booking(user: Int, service: String, date: String, time: String, is_completed: Bool, completion: @escaping (Result<BookingLoginResponse, Error>) -> Void) {
    provider.request(.booking(user: user, service: service, date: date, time: time, is_completed: true)) { result in
        switch result {
        case .success(let response):
            print("Response status code: \(response.statusCode)")
            let jsonString = String(data: response.data, encoding: .utf8) ?? "Нет данных"
            print("Полученные данные: \(jsonString)")
            
            do {
                guard (200...299).contains(response.statusCode) else {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])))
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
    func user(id: Int, completion: @escaping (Result<UserProfile, Error>) -> Void) {
            provider.request(.user(id: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        let user = try JSONDecoder().decode(UserProfile.self, from: response.data)
                        completion(.success(user))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

