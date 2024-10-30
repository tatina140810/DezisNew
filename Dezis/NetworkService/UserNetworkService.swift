import UIKit
import Moya

struct UserRegisterResponse: Codable {
    let message: String
}

struct UserLoginResponse: Decodable {
    let detail: String
   // let tokens: Tokens
}
//struct Tokens: Decodable {
//    let refresh: String
//    let access: String
//}

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
    
    // Общая функция для обработки успешного ответа с декодированием данных или ошибкой
    private func handleResponse<T: Decodable>(_ response: Response, type: T.Type) -> Result<T, Error> {
        do {
            guard (200...299).contains(response.statusCode) else {
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                return .failure(LoginError.serverError(message: errorResponse.message))
            }
            let decodedData = try JSONDecoder().decode(T.self, from: response.data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
    func userRegister(username: String, email: String, password: String, apartmentNumber: String, address: String, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
        provider.request(.userRegister(username: username, email: email, password: password, apartmentNumber: apartmentNumber, address: address)) { result in
            switch result {
            case .success(let response):
                completion(self.handleResponse(response, type: UserRegisterResponse.self))
                
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
                        let errorResponse = try JSONDecoder().decode(AdminErrorResponse.self, from: response.data)
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.detail])))
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
        func booking(service: String, date: String, time: String, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
            provider.request(.booking(service: service, date: date, time: time)) { result in
                switch result {
                case .success(let response):
                    completion(self.handleResponse(response, type: UserRegisterResponse.self))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }


