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
                // Обрабатываем успешный ответ
                do {
                    // Пример: декодируем ответ в JSON
                    let jsonResponse = try JSONSerialization.jsonObject(with: response.data, options: [])
                    print("Ответ сервера: \(jsonResponse)")
                } catch {
                    print("Ошибка декодирования ответа: \(error)")
                }
            case .failure(let error):
                // Обрабатываем ошибку запроса
                print("Ошибка запроса: \(error.localizedDescription)")
            }
        }
    }

//    func userLogin(email: String, password: String, completion: @escaping (Result<UserLoginResponse, Error>) -> Void) {
//        provider.request(.userLogin(password: password, email: email)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    
//                    guard (200...299).contains(response.statusCode) else {
//                        return
//                        print("status code: \(response.statusCode)")
//                    }
//                    let loginResponse = try JSONDecoder().decode(UserLoginResponse.self, from: response.data)
//                    completion(.success(loginResponse))
//                    print("успешно")
//                } catch {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//                print("Ошибка входа")
//            }
//        }
//    }
}





//    func requestToken() {
//        let username = "tatinaios"
//        let password = "123tatinaios!!!"
//        
//        provider.request(.getToken(username: username, password: password)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    if let json = try response.mapJSON() as? [String: Any],
//                       let token = json["access"] as? String,
//                       let refreshToken = json["refresh"] as? String {
//
//                        let tokenResponse = UserTokenResponseModel(accessToken: token, refreshToken: refreshToken)
//                        self.keichein.saveToken(token: tokenResponse)
//                        
//                        print("Полученный токен: \(token)")
//                       
//                        self.fetchNews()
//                    } else {
//                        print("Токен не найден в ответе.")
//                    }
//                } catch {
//                    print("Ошибка при маппинге ответа: \(error.localizedDescription)")
//                }
//            case .failure(let error):
//                print("Ошибка запроса: \(error.localizedDescription)")
//            }
//        }
//    }


