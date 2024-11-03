//
//  AdminLoginPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 23/10/24.
//

import UIKit

protocol IAdminLoginPresenter: AnyObject {
    func loginAdmin(login: String, password: String)
    func fetchDocumentation()
}

class AdminLoginPresenter: IAdminLoginPresenter {
    
    private var view: IAdminLoginView? = nil
    
    required init(view: IAdminLoginView) {
        self.view = view
    }
    
    let networkService = AdminNetworkService()
    
    func loginAdmin(login: String, password: String) {
        networkService.loginAdmin(login: login, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Успешный логин: \(response.detail)")
                    self?.view?.navigateToAdminDashboard()
                case .failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func fetchDocumentation() {
        networkService.fetchDocumentation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let documentationList):
                    self?.view?.showDocumentation(documentationList: documentationList)
                case .failure(let error):
                    self?.view?.showError(message: "Ошибка загрузки документации: \(error.localizedDescription)")
                }
            }
        }
    }
}
