//
//  ChatListModel.swift
//  Dezis
//
//  Created by Nurtilek on 11/26/24.
//

import Foundation

protocol ChatListModelProtocol {
    var model: ChatListModel { get }
}

struct ChatListModel: Decodable {
    let id: Int
    let user: Int
    let manager: Int
    let created_at: Int
    let message: [messages]
}

struct messages: Decodable {
    let id: Int
    let chat: Int
    let sender: Int
    let text: String
    let created_at: Int
    let is_read: Bool
}
