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

    var userLoginInfo: UserLoginInfo? = UserLoginInfo(password: "", email: "")

    func getLoginInfo() -> UserLoginInfo? {
        return userLoginInfo
    }

    func loginUser(userLoginInfo: UserLoginInfo) {
        userRegisterNetworkService.userLogin(email: userLoginInfo.email, password: userLoginInfo.password) { result in
            switch result {
            case .success(let response):
                print("Успешный вход: \(response)")

            case .failure(let error):
                if let loginError = error as? LoginError {
                    switch loginError {
                    case .invalidCredentials:
                        print("Неправильный пароль или email.")
                    case .serverError(let message):
                        print("Ошибка сервера: \(message)")
                    }
                } else {
                    print("Неизвестная ошибка: \(error.localizedDescription)")
                }
            }
        }
    }
}
