import UIKit
import Moya

struct UserRegisterResponse: Codable {
    let message: String

}
struct ErrorResponse: Codable {
    let message: String
}

class UserNetworkService {
    
    private let keychain = KeychainService()
    private let provider = MoyaProvider<UserApi>()
    
  
    func userRegister(username: String, email: String, number: String, apartmentNumber: String, address: String, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
        provider.request(.userRegister(username: username, email: email, number: number, apartmentNumber: apartmentNumber, address: address)) { result in
            switch result {
            case .success(let response):
                do {
                    
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])))
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


