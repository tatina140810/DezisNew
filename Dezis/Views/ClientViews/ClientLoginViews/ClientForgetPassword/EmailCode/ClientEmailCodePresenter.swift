//
//  ClientEmailCodePresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientEmailCodePresenter: AnyObject {
    func verifyUser(email: String, otp: String)
}

class ClientEmailCodePresenter: IClientEmailCodePresenter {
    
    private var view: IClientEmailCodeView? = nil
    private var userId: Int?
    
    init(view: IClientEmailCodeView, userId: Int) {
        self.view = view
        self.userId = userId
    }
    
    let networkService = UserNetworkService()
    
    func verifyUser(email: String, otp: String) {
        view?.showLoading()
        networkService.verifyUser(email: email, otp: otp) { [weak self] result in
            self?.view?.hideLoading()
            switch result {
            case .success:
                self?.view?.navigateToNextScreen(with: self?.userId ?? 0)
            case .failure(let error):
                let errorMessage = (error as NSError).userInfo[NSLocalizedDescriptionKey] as? String ?? "Ошибка подтверждения"
                self?.view?.showInputError(message: errorMessage)
            }
        }
    }
}
