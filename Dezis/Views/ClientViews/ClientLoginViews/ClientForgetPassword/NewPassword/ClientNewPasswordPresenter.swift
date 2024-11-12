//
//  ClientForgetPasswordPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientNewPasswordPresenter: AnyObject {
    func updatePassword(newPassword: String)
}

class ClientNewPasswordPresenter: IClientNewPasswordPresenter {
    
    private var view: IClientNewPasswordView?
    private let networkService = UserNetworkService()
    private let userId: Int
    
    init(view: IClientNewPasswordView, userId: Int) {
        self.view = view
        self.userId = userId
    }
    
    func updatePassword(newPassword: String) {
        view?.showLoading()
        networkService.updateUserPassword(userId: userId, newPassword: newPassword) { [weak self] result in
            self?.view?.hideLoading()
            switch result {
            case .success:
                self?.view?.navigateToLoginScreen()
            case .failure(let error):
                let errorMessage = (error as NSError).userInfo[NSLocalizedDescriptionKey] as? String ?? "Ошибка смены пароля"
                self?.view?.showInputError(message: errorMessage)
            }
        }
    }
}
