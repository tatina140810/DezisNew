import Foundation

class PersonalAccountPresenter {
    
    weak var view: PersonalAccountView?
    private let userService: UserNetworkService
    
    init(view: PersonalAccountView, userService: UserNetworkService) {
        self.view = view
        self.userService = userService
    }
    
    func fetchUserData(userID: Int) {
        userService.user(id: userID) { [weak self] result in
            switch result {
            case .success(let user):
                self?.view?.showUserData(user: user)
            case .failure(let error):
                self?.view?.showError("Failed to load user data: \(error.localizedDescription)")
            }
        }
    }
}
