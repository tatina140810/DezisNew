
import Foundation
import Combine

class WebSocketManager: NSObject, ObservableObject, URLSessionDelegate {
    
    private var webSocketTask: URLSessionWebSocketTask?
    private var session: URLSession!
    
    @Published var messages = [String]()
    @Published var connectionState = false
    @Published var errorState: String?
    
    private let token: String
    private let roomId: Int
    
    init(token: String, roomId: Int) {
        self.token = token
        self.roomId = roomId
        super.init()
        self.session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    func connect() {
        let url = URL(string: "wss://dezis.pp.ua/ws/chat/\(roomId)/?token=\(token)")!
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        listenForMessages()
    }
    
    private func listenForMessages() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorState = "Error: \(error)"
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.messages.append(text)
                    self?.connectionState = true
                case .data:
                    break
                }
                self?.listenForMessages()
            }
        }
    }
    
    func sendMessage(chatId: String, userId: String, messageContent: String) {
        let requestId = String(Int(Date().timeIntervalSince1970 * 1000))
        let message: [String: Any] = [
            "action": "chat_message",
            "message": messageContent,
            "user": userId,
            "request_id": requestId
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: message, options: [])
            if let messageString = String(data: data, encoding: .utf8) {
                webSocketTask?.send(.string(messageString)) { error in
                    if let error = error {
                        print("Ошибка при отправке сообщения: \(error.localizedDescription)")
                    } else {
                        print("Отправлено сообщение: \(messageString)")
                    }
                }
            }
        } catch {
            print("Ошибка сериализации JSON: \(error.localizedDescription)")
        }
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}
