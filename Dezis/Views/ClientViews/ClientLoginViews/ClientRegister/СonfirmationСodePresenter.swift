import UIKit
import Foundation

protocol IСonfirmationСodePresenter: AnyObject {
    
    func verifyUser(email: String, otp: String, completion: @escaping (Result<String, Error>) -> Void)
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
}

