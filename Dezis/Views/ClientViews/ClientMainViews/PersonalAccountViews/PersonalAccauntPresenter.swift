import Foundation

protocol IPersonalAccountPresenter: AnyObject {
    func fetchUserData()
    func updateUserNumber(newNumber: String)
    
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

    func updateUserNumber(newNumber: String) {
        let id = UserDefaults.standard.integer(forKey: "userId")
        guard id != 0 else {
            print("Ошибка: Id не найден в UserDefaults")
            return
        }
        userService.updateUserNumber(userId: id, newNumber: newNumber){result in
            switch result {
            case .success :
                DispatchQueue.main.async {
                    let customAlert = NumberSavedAlert()
                    self.view?.showCustomAlert(customAlert)
                    
                    print("Номер пользователя успешно обновлен")}
            case .failure(let error):
                print("Ошибка при обновлении номера пользователя: \(error)")
                
            }
        }
    }
    
}
