import UIKit
import Foundation

protocol IUserRegisterPresenters: AnyObject {
    
    func getUserInfo() -> UserInfo?
    
    func registerUser(userInfo: UserInfo, completion: @escaping (Bool) -> Void)
}

class UserRegisterPresenter: IUserRegisterPresenters {
   
    let userNetworkService = UserNetworkService()
    
    var view: IUserRegisterSecondPageViewController?
    
    var userInfo: UserInfo?

   
    func getUserInfo() -> UserInfo? {
        return userInfo
    }
    
    func registerUser(userInfo: UserInfo, completion: @escaping (Bool) -> Void) {
        userNetworkService.userRegister(username: userInfo.username, email: userInfo.email, password: userInfo.password, apartmentNumber: userInfo.apartmentNumber, address: userInfo.address) { [weak self] result in
            switch result {
            case .success(let response):
                        print("Registration successful with response: \(response)")
                        let id = response.id
                print ("User id: \(id)")
                        completion(true)
                    case .failure(let error):
                        print("Registration failed with error: \(error.localizedDescription)")
                        completion(false)
                    }
        }
        
    }
   
}

