//import Foundation
//// Модель данных для чатов
//struct Chat: Codable {
//    let id: Int
//    let user: User
//    let manager: User?
//    let messages: [Message]
//}
//
//struct User: Codable {
//    let id: Int
//    let username: String?
//    let email: String
//}
//
//struct Message: Codable {
//    let id: Int
//    let sender: User
//    let text: String?
//    let isRead: Bool
//    let createdAt: String
//}
//
//// Запрос для получения списка чатов
//func fetchChats(completion: @escaping ([Chat]?, Error?) -> Void) {
//    guard let url = URL(string: "https://your-backend.com/chats/") else { return }
//    
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.addValue("Bearer YOUR_TOKEN", forHTTPHeaderField: "Authorization") // Токен пользователя
//    
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            completion(nil, error)
//            return
//        }
//        
//        guard let data = data else { return }
//        
//        do {
//            let chats = try JSONDecoder().decode([Chat].self, from: data)
//            completion(chats, nil)
//        } catch {
//            completion(nil, error)
//        }
//    }
//    
//    task.resume()
//}
//
//// Запрос для отправки сообщения
//func sendMessage(chatId: Int, messageText: String, completion: @escaping (Message?, Error?) -> Void) {
//    guard let url = URL(string: "https://your-backend.com/messages/send/") else { return }
//    
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("Bearer YOUR_TOKEN", forHTTPHeaderField: "Authorization")
//    
//    let messageData = ["chat": chatId, "text": messageText]
//    guard let httpBody = try? JSONSerialization.data(withJSONObject: messageData, options: []) else { return }
//    
//    request.httpBody = httpBody
//    
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            completion(nil, error)
//            return
//        }
//        
//        guard let data = data else { return }
//        
//        do {
//            let message = try JSONDecoder().decode(Message.self, from: data)
//            completion(message, nil)
//        } catch {
//            completion(nil, error)
//        }
//    }
//    
//    task.resume()
//}
