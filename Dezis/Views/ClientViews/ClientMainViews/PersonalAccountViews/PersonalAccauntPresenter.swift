import Foundation

protocol IPersonalAccountPresenter: AnyObject {
    func fetchUserData()
}

class PersonalAccountPresenter: IPersonalAccountPresenter {
    
    weak var view: PersonalAccountView?
    private let userService: UserNetworkService

    init(view: PersonalAccountView, userService: UserNetworkService) {
        self.view = view
        self.userService = userService
    }
    
    func fetchUserData() {
       
        guard let userId = UserDefaults.standard.value(forKey: "userID") as? Int else {
            DispatchQueue.main.async {
                self.view?.showError("User ID not found in UserDefaults.")
            }
            return
        }
       
        userService.fetchUser(id: userId) { [weak self] result in
            switch result {
            case .success(let userProfile):
                print("User profile fetched: \(userProfile)")
                
                DispatchQueue.main.async {
                    self?.view?.showUserData(user: userProfile)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    let errorMessage = (error as NSError).localizedDescription
                    self?.view?.showError("Failed to load user data: \(errorMessage)")
                }
            }
        }
    }
}
