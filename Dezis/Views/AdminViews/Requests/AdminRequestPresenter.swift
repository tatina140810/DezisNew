//
//  AdminRequestPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 24/10/24.
//

import UIKit

protocol IAdminRequestPresenter: AnyObject {

}

class AdminRequestPresenter: IAdminRequestPresenter {
    
    private var view: IAdminHistoryView? = nil
    
    required init(view: IAdminHistoryView) {
        self.view = view
    }
    
}
