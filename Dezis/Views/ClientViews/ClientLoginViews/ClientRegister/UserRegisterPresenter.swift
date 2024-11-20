import UIKit
import Moya
import Foundation

protocol IUserRegisterPresenters: AnyObject {
    func getUserInfo() -> UserInfo?
    func registerUser(userInfo: UserInfo, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void)
}

class UserRegisterPresenter: IUserRegisterPresenters {
    
    let userNetworkService = UserNetworkService()
    var view: IUserRegisterSecondPageViewController?
    var userInfo: UserInfo?
    
    func getUserInfo() -> UserInfo? {
        return userInfo
    }
    
    func registerUser(userInfo: UserInfo, completion: @escaping (Result<UserRegisterResponse, Error>) -> Void) {
        userNetworkService.userRegister(username: userInfo.username, email: userInfo.email, number: userInfo.number, password: userInfo.password, apartmentNumber: userInfo.apartmentNumber, address: userInfo.address) { result in
            switch result {
            case .success(let registerResponse):
                if let userId = registerResponse.id {
                    UserDefaults.standard.set(userId, forKey: "userId")
                    print("User ID \(userId) has been saved to UserDefaults.")
                } else {
                    print("User ID not found in response.")
                }
                let tokens = UserTokenResponseModel(
                    accessToken: registerResponse.tokens.access,
                    refreshToken: registerResponse.tokens.refresh
                )
                KeychainService.shared.saveToken(token: tokens)

                if KeychainService.shared.hasTokens() {
                    print("Токены успешно сохранены!")
                } else {
                    print("Токены не сохранены.")
                }
                completion(.success(registerResponse))
                
            case .failure(let error):
                print("Failed to register user: \(error)")
                completion(.failure(error))
            }
        }
    }
}
