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
        guard let currentUserId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            DispatchQueue.main.async {
                self.view?.showError("User ID not found in UserDefaults.")
            }
            return
        }
        
        userService.fetchUser(id: currentUserId) { [weak self] result in
            switch result {
            case .success(let userProfile):
                print("User profile fetched: \(userProfile)")
                
               
                if let fetchedUserId = userProfile.id, fetchedUserId != currentUserId {
                
                    UserDefaults.standard.set(fetchedUserId, forKey: "userId")
                    print("User ID обновлен в UserDefaults: \(fetchedUserId)")
                }
                
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
