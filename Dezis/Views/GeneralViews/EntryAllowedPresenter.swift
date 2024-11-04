import Foundation

protocol IEntryAllowedPresenter: AnyObject {
    func fetchUserData()
}

class EntryAllowedPresenter: IEntryAllowedPresenter {
    
    weak var view: EntryAllowedView?
    private let userService: UserNetworkService

    init(view: EntryAllowedView, userService: UserNetworkService) {
        self.view = view
        self.userService = userService
    }
    
    func fetchUserData() {
        guard let email = UserDefaults.standard.string(forKey: "email"), !email.isEmpty else {
            print("Error: Email is empty or not saved in UserDefaults")
            view?.showError("Email is not available in UserDefaults.")
            return
        }
        
        print("Fetching user data for email: \(email)")

        userService.getUserProfile(email: email) { [weak self] result in
            switch result {
            case .success(let userProfile):
                print("User profile fetched: \(userProfile)")
                if let userID = userProfile.id {
                                   UserDefaults.standard.set(userID, forKey: "userID")
                                   print("User ID saved in UserDefaults: \(userID)")
                               }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError("Failed to load user data: \(error.localizedDescription)")
                }
            }
        }
    }
}
