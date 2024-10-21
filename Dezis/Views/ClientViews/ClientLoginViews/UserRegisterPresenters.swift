import UIKit
import Foundation

protocol IUserRegisterPresenters: AnyObject {
   // init(view: INewUserRegisterViewController, secondView: IUserRegisterSecondPageViewController)
    
//    func updateUserInfo(username: String, email: String, password: String)
//    func updateSecondPageInfo(adress: String, apartmentNumber: String)
//    func getRegistrInfo() -> (username: String, email: String, password: String)
//    func getSecondPageRegisterInfo() -> (adress: String, apartmentNumber: String)
    func getUserInfo() -> UserInfo?
    
    func registerUser(userInfo: UserInfo)
}

class UserRegisterPresenters: IUserRegisterPresenters {
    func registerUser(userInfo: UserInfo) {
        userRegisterNetworkSeervice.userRegister(username: userInfo.username, email: userInfo.email, number: userInfo.password, apartmentNumber: userInfo.appartmentNumber, address: userInfo.address) { [weak self] result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
  
    
    let userRegisterNetworkSeervice = UserNetworkService()
    
  //  var view: INewUserRegisterViewController?
    var view: IUserRegisterSecondPageViewController?
    
    var userInfo: UserInfo?
    
//    required init(view: INewUserRegisterViewController, secondView: IUserRegisterSecondPageViewController) {
//        self.view = view
//        self.secondView = secondView
//    }
//    func getRegistrInfo() -> (username: String, email: String, password: String) {
//        return (userInfo.username, userInfo.email, userInfo.password)
//    }
//    func getSecondPageRegisterInfo() -> (adress: String, apartmentNumber: String) {
//        return (userInfo.adress, userInfo.apartmentNumber)
//    }
//    func updateUserInfo(username: String, email: String, password: String) {
//        self.userInfo.username = username
//        self.userInfo.email = email
//        self.userInfo.password = password
//        print(userInfo)
//    }
//  
//    func updateSecondPageInfo(adress: String, apartmentNumber: String) {
//        self.userInfo.adress = adress
//        self.userInfo.apartmentNumber = apartmentNumber
//        print(userInfo)
//    }
    func registerApi(userInfo: (username: String, email: String, password: String, adress: String, apartmentNumber: String)) {
        
        userRegisterNetworkSeervice.userRegister(
            username: userInfo.username,
            email: userInfo.email,
            number: userInfo.password,
            apartmentNumber: userInfo.apartmentNumber,
            address: userInfo.adress
        ) { result in
            switch result {
            case .success(let response):
                // Handle success, e.g., notify the view
                print("Registration success: \(response)")
            case .failure(let error):
                // Handle error, e.g., notify the view
                print("Registration failed with error: \(error)")
            }
        }
    }
    
    func getUserInfo() -> UserInfo? {
        return userInfo
    }
    

}

