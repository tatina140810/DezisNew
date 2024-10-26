//import Foundation
//import UIKit
//
//protocol IClienLogInPresenter: AnyObject {
//    func getLoginInfo() -> UserLoginInfo?
//    
//    func loginUser(userLoginInfo: UserLoginInfo)
//    
//}
//enum LoginError: Error {
//    case invalidCredentials
//    case serverError(message: String)
//}
//
//
//class ClientLogInPresenter: IClienLogInPresenter {
//    var view: IClientLoginViewController?
//    
//    let userRegisterNetworkService = UserNetworkService()
//    
//    var userLoginInfo: UserLoginInfo? = UserLoginInfo(password: "", email: "") 
//    
//    func getLoginInfo() -> UserLoginInfo? {
//        return userLoginInfo
//    }
//    
//    func loginUser(userLoginInfo: UserLoginInfo) {
//        userRegisterNetworkService.userLogin(email: userLoginInfo.email, password: userLoginInfo.password) { result in
//            switch result {
//            case .success(let response):
//                print("Успешный вход: \(response)")
//                
//            case .failure(let error):
//                if let loginError = error as? LoginError {
//                    switch loginError {
//                    case .invalidCredentials:
//                        print("Неправильный пароль или email.")
//                    case .serverError(let message):
//                        print("Ошибка сервера: \(message)")
//                    }
//                } else {
//                    print("Неизвестная ошибка: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//}

import Moya

protocol LoginPresenterProtocol: AnyObject {
    func loginSuccess()
    func loginFailed(error: String)
}

class LoginPresenter {
    
    weak var view: LoginPresenterProtocol?
    private let provider = MoyaProvider<UserApi>()
    
    init(view: LoginPresenterProtocol) {
        self.view = view
    }

    func loginUser(email: String, password: String) {
        provider.request(.userLogin(email: email, password: password)) { [weak self] result in
            switch result {
            case .success(let response):
                print("Статус-код: \(response.statusCode)")
                print("Тело ответа: \(String(data: response.data, encoding: .utf8) ?? "Нет данных")")
                
                do {
                 
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                        let errorMessage = errorResponse?["message"] as? String ?? "Ошибка сервера"
                        self?.view?.loginFailed(error: errorMessage)
                        return
                    }
                 
                    print("Успешный вход")
                    
                    self?.view?.loginSuccess()
                    
                } catch {
                  
                    self?.view?.loginFailed(error: "Ошибка обработки данных")
                }
            case .failure(let error):
              
                self?.view?.loginFailed(error: error.localizedDescription)
            }
        }
    }

}
