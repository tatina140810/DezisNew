//
//  ClientEmailConfirmPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientEmailConfirmPresenter: AnyObject {
   
}

class ClientEmailConfirmPresenter: IClientEmailConfirmPresenter {
    
    private var view: IClientEmailConfirmView? = nil
    
    required init(view: IClientEmailConfirmView) {
        self.view = view
    }
    
    let networkService = UserNetworkService()
    
    
}
