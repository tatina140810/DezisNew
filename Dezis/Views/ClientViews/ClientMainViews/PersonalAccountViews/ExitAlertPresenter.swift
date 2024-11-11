import Foundation

protocol IExitAlertPresenter: AnyObject {
    func logOut()
}

class ExitAlertPresenter: IExitAlertPresenter {
    
    weak var view: ExitAlertView?
    private let userService: UserNetworkService

    init(view: ExitAlertView, userService: UserNetworkService) {
        self.view = view
        self.userService = userService
    }
    
    func logOut() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            print("Ошибка: Email не найден в UserDefaults")
            return
        }
        
        userService.logOut(email: email){ result in
            switch result {
            case .success:
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "userId")
                print("Пользователь успешно вышел из системы и данные удалены")
                
            case .failure(let error):
                print("Ошибка выхода: \(error.localizedDescription)")
            }
        }
    }

}
