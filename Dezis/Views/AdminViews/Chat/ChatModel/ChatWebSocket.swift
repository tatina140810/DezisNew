import Starscream
import SwiftSignalRClient
import Starscream

class ChatWebSocket: WebSocketDelegate {
    private var socket: WebSocket?
    private let roomId: Int
    private let token: String
    
    init(roomId: Int, token: String) {
        self.roomId = roomId
        self.token = token
    }
    
    func connect() {
        let urlString = "wss://dezis.pp.ua/ws/chat/\(roomId)/?token=\(token)"
        guard let url = URL(string: urlString) else {
            print("Invalid WebSocket URL")
            return
        }
        
        var request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    func sendMessage(text: String) {
        let messageData: [String: Any] = ["message": text]
        if let jsonData = try? JSONSerialization.data(withJSONObject: messageData) {
            socket?.write(data: jsonData)
        }
    }
    
    func sendText(text: String) {
        socket?.write(string: text)
    }
    
    // MARK: - WebSocketDelegate
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected(let headers):
            print("WebSocket connected: \(headers)")
        case .disconnected(let reason, let code):
            print("WebSocket disconnected: \(reason) with code: \(code)")
        case .text(let text):
            handleIncomingMessage(text)
        case .binary(let data):
            print("Received binary data: \(data)")
        case .error(let error):
            print("WebSocket error: \(error?.localizedDescription ?? "unknown error")")
        default:
            break
        }
    }
    
    private func handleIncomingMessage(_ text: String) {
        print("Incoming message: \(text)")
    }
}

class SignalRService {
    private var connection: HubConnection
    private let roomId: Int
    private let token: String
    
    init(roomId: Int, token: String) {
        self.roomId = roomId
        self.token = token
        let urlString = "wss://dezis.pp.ua/ws/chat/\(roomId)/?token=\(token)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid SignalR URL")
        }
        
        connection = HubConnectionBuilder(url: url)
            .withHttpConnectionOptions { options in
                options.headers = ["Authorization": "Bearer \(token)"]
            }
            .withAutoReconnect()
            .build()
        
        connection.on(method: "MessageReceived", callback: { (user: String, message: String) in
            print("Message from \(user): \(message)")
        })
    }
    
    func connectionStart() {
        connection.start()
    }
    
    func connectionStop() {
        connection.stop()
    }
}
