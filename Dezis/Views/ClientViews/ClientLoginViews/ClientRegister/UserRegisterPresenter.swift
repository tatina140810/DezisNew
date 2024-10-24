import UIKit
import Foundation

protocol IUserRegisterPresenters: AnyObject {
    
    func getUserInfo() -> UserInfo?
    
    func registerUser(userInfo: UserInfo)
}

class UserRegisterPresenter: IUserRegisterPresenters {
    
    let userNetworkSeervice = UserNetworkService()
    
    var view: IUserRegisterSecondPageViewController?
    
    var userInfo: UserInfo?
    
    func registerUser(userInfo: UserInfo) {
        userNetworkSeervice.userRegister(username: userInfo.username, email: userInfo.email, password: userInfo.password, apartmentNumber: userInfo.appartmentNumber, address: userInfo.address) { [weak self] result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
      func getUserInfo() -> UserInfo? {
        return userInfo
    }
    

}

