import UIKit
import Moya

struct UserRegisterResponse: Codable {
    let message: String

}
struct UserLoginResponse: Codable {
    let email: String
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
    func userLogin(email: String, password: String) {
        provider.request(.userLogin(email: email, password: password)) { result in
            switch result {
            case .success(let response):
                do {
                    
                    let jsonResponse = try JSONSerialization.jsonObject(with: response.data, options: [])
                    print("Ответ сервера: \(jsonResponse)")
                } catch {
                    print("Ошибка декодирования ответа: \(error)")
                }
            case .failure(let error):
                
                print("Ошибка запроса: \(error.localizedDescription)")
            }
        }
    }
    func booking(service: String, date: String, time: String, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
        provider.request(.booking(service: service, date: date, time: time)) { result in
            switch result {
            case .success(let response):
                do {
                    
                    let jsonResponse = try JSONSerialization.jsonObject(with: response.data, options: [])
                    print("Ответ сервера: \(jsonResponse)")
                } catch {
                    print("Ошибка декодирования ответа: \(error)")
                }
            case .failure(let error):
                
                print("Ошибка запроса: \(error.localizedDescription)")
            }
        }
    }
}

