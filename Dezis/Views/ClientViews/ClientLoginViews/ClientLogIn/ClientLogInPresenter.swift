import Foundation
import UIKit

protocol IClienLogInPresenter: AnyObject {
    func getLoginInfo() -> UserLoginInfo?

    func loginUser(userLoginInfo: UserLoginInfo)

}
enum LoginError: Error {
    case invalidCredentials
    case serverError(message: String)
}


class ClientLogInPresenter: IClienLogInPresenter {
  var view: IClientLoginViewController?

    let userRegisterNetworkService = UserNetworkService()

    var userLoginInfo: UserLoginInfo? = UserLoginInfo(email: "", password: "")

    func getLoginInfo() -> UserLoginInfo? {
        return userLoginInfo
    }

    func loginUser(userLoginInfo: UserLoginInfo) {
           userRegisterNetworkService.userLogin(email: userLoginInfo.email, password: userLoginInfo.password) { [weak self] result in
               switch result {
               case .success(let response):
                   DispatchQueue.main.async {
                       print("Успешный вход: \(response)")
                       self?.view?.loginSuccess()
                   }
                case .failure(let error):
                   DispatchQueue.main.async {
                                      self?.view?.loginFailed(error: error.localizedDescription)
                                  }
                    
                    if var loginError = error as? LoginError {
                        switch loginError {
                        case .invalidCredentials:
                            print("Неправильный пароль или email.")
                            self?.view?.loginFailed(error: "Неправильный пароль или email.")
                        case .serverError(let message):
                            print("Ошибка сервера: \(message)")
                            self?.view?.loginFailed(error: "Ошибка сервера: \(message)")
                        }
                    } else {
                        // Обработка ошибок, не относящихся к LoginError
                        print("Неизвестная ошибка: \(error.localizedDescription)")
                        self?.view?.loginFailed(error: "Неизвестная ошибка: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
