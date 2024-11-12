//
//  ClientEmailConfirmPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientEmailConfirmPresenter: AnyObject {
    func forgotPassword(email: String)
}

class ClientEmailConfirmPresenter: IClientEmailConfirmPresenter {
    
    private var view: IClientEmailConfirmView?
    private var userId: Int?
    
    init(view: IClientEmailConfirmView) {
        self.view = view
    }
    
    let networkService = UserNetworkService()
    
    func forgotPassword(email: String) {
        view?.showLoading()
        networkService.forgotPassword(email: email) { [weak self] result in
            self?.view?.hideLoading()
            switch result {
            case .success(let userId):
                self?.userId = userId
                print("User ID: \(userId)")
                self?.view?.navigateToNextScreen(with: email, userId: userId)
                
            case .failure(let error):
                let errorMessage = (error as NSError).userInfo[NSLocalizedDescriptionKey] as? String ?? "Ошибка отправки"
                self?.view?.showInputError(message: errorMessage)
            }
        }
    }
}
