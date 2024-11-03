import Foundation

class PersonalAccountPresenter{
    
    weak var view: PersonalAccountView?
    private let userService: UserNetworkService
    
    init(view: PersonalAccountView, userService: UserNetworkService) {
        self.view = view
        self.userService = userService
    }
 
//    func fetchUserData(email: String) {
//        userService.getUserProfile(email: email) { [weak self] result in
//            switch result {
//            case .success(let userProfile):
//                self?.view?.showUserData(user: userProfile)
//            case .failure(let error):
//                self?.view?.showError("Failed to load user data: \(error.localizedDescription)")
//            }
//        }
//    }
}
