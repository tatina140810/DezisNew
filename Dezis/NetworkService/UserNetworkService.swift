import UIKit
import Moya

struct UserRegisterResponse: Codable {
    let message: String
}

struct UserLoginResponse: Codable {
    let detail: String
    let tokens: String
}

struct ErrorResponse: Codable {
    let message: String
}

class UserNetworkService {
    
    private let keychain = KeychainService()
    private let provider = MoyaProvider<UserApi>()
    
    func userRegister(username: String, email: String, password: String, apartmentNumber: String, address: String, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
        provider.request(.userRegister(username: username, email: email, password: password, apartmentNumber: apartmentNumber, address: address)) { result in
            switch result {
            case .success(let response):
                do {
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(LoginError.serverError(message: errorResponse.message)))
                        return
                    }
                    let userResponse = try JSONDecoder().decode(UserRegisterResponse.self, from: response.data)
                    completion(.success(userResponse))
                } catch {
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
                do {
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(LoginError.serverError(message: errorResponse.message)))
                        return
                    }
                    let userResponse = try JSONDecoder().decode(UserLoginResponse.self, from: response.data)
                    completion(.success(userResponse))
                } catch {
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
                do {
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(LoginError.serverError(message: errorResponse.message)))
                        return
                    }
                    let userResponse = try JSONDecoder().decode(UserRegisterResponse.self, from: response.data)
                    completion(.success(userResponse))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
