//
//  MainPresenter.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 13/10/24.
//
import UIKit
import Foundation

protocol IClientChatPresenter: AnyObject {
    init(view: IClientChatViewController)
    func getChats() -> [(message: String, time: String, checkmark: UIImage)]
}
class ClientChatPresenter: IClientChatPresenter {
    
   
    private var view: IClientChatViewController? = nil
    
    private let messages: [(message: String, time: String, checkmark: UIImage)] = [
        (message: "Здравствуйте!", time: "18:48", checkmark: UIImage(resource: .twoRead)),
        (message: "Здраствуйте! Все хорошо, как я могу расплатится?!", time: "18:49", checkmark: UIImage(resource: .twoRead)),
        (message: "Хорошо", time: "18:50", checkmark: UIImage(resource: .twoRead))
    ]
    required init(view: IClientChatViewController) {
        self.view = view
        
    }
    func getChats() -> [(message: String, time: String, checkmark: UIImage)] {
        return messages
    }

}
