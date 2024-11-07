import UIKit


protocol IClientLoginPresenter: AnyObject {
    func loginUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
}


class ClientLoginPresenter: IClientLoginPresenter {
    let networkService = UserNetworkService()
    
    private var view: IClientLoginViewController?
    
    init(view: IClientLoginViewController) {
        self.view = view
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
           networkService.userLogin(email: email, password: password) { result in
               switch result {
               case .success(let response):
                   print("Успешный логин: \(response.detail)")
                   UserDefaults.standard.set(email, forKey: "email")
                   print("сoхраненый email: \(email)")
                   
                   DispatchQueue.main.async {
                       completion(.success(response.detail))
                       
                   }
               case .failure(let error):
                   DispatchQueue.main.async {
                       completion(.failure(error))
                   }
               }
           }
       }
    func fetchUserData() {
        guard let email = UserDefaults.standard.string(forKey: "email"), !email.isEmpty else {
            print("Ошибка: Email пуст или не сохранен в UserDefaults")
            return
        }
        
        print("Fetching user data for email: \(email)")

        networkService.getUserProfile(email: email) { result in
            switch result {
            case .success(let userProfile):
                print("User profile fetched: \(userProfile)")
                if let userID = userProfile.id {
                                   UserDefaults.standard.set(userID, forKey: "userID")
                                   print("User ID saved in UserDefaults: \(userID)")
                               }
                
            case .failure(let error):
                DispatchQueue.main.async {
                   print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
