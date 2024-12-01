//
//  ChatListModel.swift
//  Dezis
//
//  Created by Nurtilek on 11/26/24.
//

import Foundation

class ChatAPI {
    private let token: String
    private let urlString = "https://dezis.pp.ua/api/v1/chat/chats/"
    
    init(token: String) {
        self.token = token
    }

    // Получение сообщений чата
    func fetchChatMessages(chatId: Int, completion: @escaping (Result<[Message], Error>) -> Void) {
        guard let url = URL(string: "\(urlString)\(chatId)/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let chat = try decoder.decode(Chat.self, from: data)
                completion(.success(chat.messages))
            } catch {
                completion(.failure(error))
            }
        }
    }
        // Получение списка чатов
        func fetchChats(completion: @escaping (Result<[Chat], Error>) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
                return
            }
            
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let chats = try decoder.decode([Chat].self, from: data)
                    completion(.success(chats))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    
}

struct Chat: Codable {
    let id: Int
    let user: Int
    let manager: Int
    let createdAt: String
    let messages: [Message]

    enum CodingKeys: String, CodingKey {
        case id, user, manager, createdAt = "created_at", messages
    }
}

struct Message: Codable {
    let id: Int
    let chat: Int
    let sender: Int
    let text: String
    let createdAt: String
    let isRead: Bool

    enum CodingKeys: String, CodingKey {
        case id, chat, sender, text, createdAt = "created_at", isRead = "is_read"
    }
}
