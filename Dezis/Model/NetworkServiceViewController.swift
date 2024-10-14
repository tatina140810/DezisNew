import UIKit
import Moya

class NetworkServiceViewController: UIViewController {
    
    let provider = MoyaProvider<APIService>()
    var accessToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestToken()
    }
    
    func fetchNews() {
        
        guard let token = accessToken else {
            print("Токен отсутствует, получение новостей невозможно.")
            return
        }
        provider.request(.news) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try response.mapJSON()
                    print("News Response JSON: \(json)")
                } catch {
                    print("Mapping Error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func requestToken() {
        let username = "admin@mail.com"
        let password = "123"
        
        provider.request(.getToken(username: username, password: password)) { result in
            switch result {
            case .success(let response):
                do {
                    if let json = try response.mapJSON() as? [String: Any],
                       let token = json["access"] as? String {
                        self.accessToken = token
                        print("Полученный токен: \(token)")
                        self.fetchNews()
                    } else {
                        print("Токен не найден в ответе.")
                    }
                } catch {
                    print("Ошибка при маппинге ответа: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Ошибка запроса: \(error.localizedDescription)")
            }
        }
    }
}

