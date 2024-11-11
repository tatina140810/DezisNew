//
//  ClientEmailCodePresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 09/11/24.
//

import UIKit

protocol IClientEmailCodePresenter: AnyObject {
   
}

class ClientEmailCodePresenter: IClientEmailCodePresenter {
    
    private var view: IClientEmailCodeView? = nil
    
    required init(view: IClientEmailCodeView) {
        self.view = view
    }
    
    let networkService = UserNetworkService()
    
    
}
