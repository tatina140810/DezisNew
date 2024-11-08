//
//  ClientForgetPasswordPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientForgetPasswordPresenter: AnyObject {
   
}

class ClientForgetPasswordPresenter: IClientForgetPasswordPresenter {
    
    private var view: IClientForgetPasswordView? = nil
    
    required init(view: IClientForgetPasswordView) {
        self.view = view
    }
    
    let networkService = UserNetworkService()
    
    
}
