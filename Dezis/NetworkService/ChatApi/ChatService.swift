//
//  ChatService.swift
//  Dezis
//
//  Created by Nurtilek on 11/22/24.
//

import Moya

class ChatService {
    static let shared = ChatService()
    
    private let provider = MoyaProvider<ChatApi>()
    
    func sendMessage(message: ChatModel, completion: @escaping (Result<Int, Error>) -> Void) {
        provider.request(.sendMessage(message)) { result in
            switch result {
            case .success(let response):
                print("send message response data: \(response.data), \(response.statusCode)")
            case .failure(let error):
                print("send message error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchChatList(completion: @escaping (Result<Int, Error>) -> Void) {
        provider.request(.fetchChatList) { result in
            switch result {
            case .success(let response):
                print("send message response data: \(response.data), \(response.statusCode)")
            case .failure(let error):
                print("send message error: \(error.localizedDescription)")
            }
        }
    }
}
