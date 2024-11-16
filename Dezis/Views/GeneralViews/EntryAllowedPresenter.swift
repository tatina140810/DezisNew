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
        let id = UserDefaults.standard.integer(forKey: "userId")
        guard id != 0 else {
            print("Error: Id is empty or not saved in UserDefaults")
            view?.showError("Id не доступер в памяти.")
            return
        }
        
        print("Fetching user data for userId: \(id)")
        
        userService.userDetails(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userProfile):
                    if userProfile.isConfirmed {
                        self.view?.updateUserProfile(userProfile)
                    } 
                case .failure(_):
                    self.view?.showEntryDeniedScreen()
                    
                }
            }
        }
    }
   
}
