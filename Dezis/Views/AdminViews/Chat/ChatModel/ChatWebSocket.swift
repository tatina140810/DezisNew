import Starscream

class ChatWebSocket: WebSocketDelegate {
    var socket: WebSocket?
    
    init() {
        var request = URLRequest(url: URL(string: "ws://209.38.228.54:8084/ws/chat/")!)
        request.addValue("Bearer YOUR_TOKEN", forHTTPHeaderField: "Authorization")
        socket = WebSocket(request: request)
        socket?.delegate = self
    }
    
    func connect() {
        socket?.connect()
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    func sendMessage(text: String) {
        let messageData: [String: Any] = ["message": text]
        if let jsonData = try? JSONSerialization.data(withJSONObject: messageData, options: []) {
            socket?.write(data: jsonData)
        }
    }
    
    // WebSocketDelegate methods
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            print("WebSocket connected: \(headers)")
        case .disconnected(let reason, let code):
            print("WebSocket disconnected: \(reason) with code: \(code)")
        case .text(let text):
            handleIncomingMessage(text)
        case .binary(let data):
            print("Received data: \(data)")
        case .error(let error):
            print("WebSocket error: \(error?.localizedDescription ?? "unknown error")")
        default:
            break
        }
    }
    
    func handleIncomingMessage(_ text: String) {
         DispatchQueue.main.async { [weak self] in
             self?.messages.append((isUserMessage: false, message: text, time: self?.getCurrentTime() ?? ""))
             self?.tableView.reloadData()
         }
     }
}
