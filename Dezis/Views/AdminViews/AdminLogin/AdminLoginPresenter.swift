//
//  AdminLoginPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 23/10/24.
//

import UIKit

protocol IAdminLoginPresenter: AnyObject {
    func loginAdmin(login: String, password: String)
}

class AdminLoginPresenter: IAdminLoginPresenter {
    
    private var view: IAdminLoginView? = nil
    
    required init(view: IAdminLoginView) {
        self.view = view
    }
    
    func loginAdmin(login: String, password: String) {
        let networkService = AdminNetworkService()
        networkService.loginAdmin(login: login, password: password) { result in
            switch result {
            case .success(let response):
                print("Успешный логин: \(response.detail)")
                DispatchQueue.main.async {
                    guard let view = self.view as? UIViewController else { return }
                    let tabBarController = AdminTabBarController()
                    view.navigationController?.pushViewController(tabBarController, animated: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    guard let view = self.view else { return }
                    view.showError(message: error.localizedDescription)
                }
            }
        }
    }
}
