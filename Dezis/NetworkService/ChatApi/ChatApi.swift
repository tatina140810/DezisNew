//
//  ChatApi.swift
//  Dezis
//
//  Created by Nurtilek on 11/22/24.
//

import Moya

//{
//  "chat": 0,
//  "sender": 0,
//  "text": "string",
//  "is_read": true
//}

struct ChatModel {
    let text: String
}

enum ChatApi {
    case sendMessage(ChatModel)
    case fetchChatList
}

extension ChatApi: TargetType {
    
    var baseURL: URL { URL(string: "https://dezis.pp.ua")! }
    
    var path: String {
        switch self {
        case .sendMessage(_):
            return "/api/v1/chat/messages/send/"
        case .fetchChatList:
            return "/api/v1/chat/chats/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case.sendMessage(_):
            return .post
        case .fetchChatList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
//        case .getToken(let email, let password):
//            return .requestParameters(parameters: ["email": email,
//                                                   "password": password],
//                                      encoding: JSONEncoding.default)
        case .sendMessage(let model):
            return .requestParameters(parameters: ["text": model.text], encoding: JSONEncoding.default)
        case .fetchChatList:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMyMjgxNjg0LCJpYXQiOjE3MzIyODEwODQsImp0aSI6IjQwOGRjMWRiNDI4NDQ3NGJhYzFiMDNiZGQ2YWU0NTgzIiwidXNlcl9pZCI6Mjg1fQ.hhxWXD1ioslCzTAQitdmStV4QmVDoDy5aRjUXblXxfU"
        ]
        
//        var sampleData: Data {
//            return Data()
//        }
    }
}

