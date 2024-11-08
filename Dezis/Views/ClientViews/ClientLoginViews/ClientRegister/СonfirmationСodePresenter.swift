import UIKit
import Foundation

protocol IСonfirmationСodePresenter: AnyObject {
    
    func verifyUser(email: String, otp: String, completion: @escaping (Result<String, Error>) -> Void)
    func resendOtp()
}

class СonfirmationСodePresenter: IСonfirmationСodePresenter {
   
    let userNetworkService = UserNetworkService()
    
    private var view:  IСonfirmationСodeViewController?
    
    init(view: IСonfirmationСodeViewController) {
        self.view = view
    }
    
    func verifyUser(email: String, otp: String, completion: @escaping (Result<String, Error>) -> Void) {
        userNetworkService.verifyUser(email: email, otp: otp) {result in
            switch result {
            case .success(let response):
                print("Успешная активация: \(response.detail)")
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
    func resendOtp() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            print("Ошибка: Email не найден в UserDefaults")
            return
        }
        
        userNetworkService.resendOtp(email: email){ result in
            switch result {
            case .success:
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "userId")
                print("Код отправлен на email")
                
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
            }
        }
    }
}

