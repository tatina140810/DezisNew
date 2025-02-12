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
                UserDefaults.standard.set(response.id, forKey: "userId")
                print("Сохраненный email: \(email)")
                print("Сохраненный userId: \(response.id)")
                
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
}
