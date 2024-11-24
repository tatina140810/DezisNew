import Starscream
import SwiftSignalRClient

class ChatWebSocket: WebSocketDelegate {
   
    var socket: WebSocket?
    
    init() {
        //var request = URLRequest(url: URL(string: "ws://dezis.pp.ua//ws/chat/\(285)/?token=\(KeychainService.shared.accessToken)")!)
        var request = URLRequest(url: URL(string: "wss://dezis.pp.ua/ws/chat/\(285)")!)
        request.addValue("Bearer \(KeychainService.shared.accessToken)", forHTTPHeaderField: "Authorization")
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
    
    func sendText(text: String) {
        guard let socket = socket
            else { return }
        socket.write(string: text)
    }
    
    // WebSocketDelegate methods
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
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
       //  DispatchQueue.main.async { [weak self] in
       //      self?.messages.append((isUserMessage: false, message: text, time: self?.getCurrentTime() ?? ""))
      //       self?.tableView.reloadData()
      //   }
     }
}

public class SignalRService {
    private var connection: HubConnection
    
    public init(url: URL) {
        connection = HubConnectionBuilder(url: url).withHttpConnectionOptions(configureHttpOptions: { httpConnectionOptions in
                    httpConnectionOptions.headers = ["Authorization": "Bearer \(KeychainService.shared.accessToken)"]
                })
                .withAutoReconnect()
               // .withLogging(minLogLevel: .debug)
                .build()

        connection.on(method: "MessageReceived", callback: { (user: String, message: String) in
            do {
                self.handleMessage(message, from: user)
            } catch {
                print(error)
            }
        })
      //  connection.start()
    }
    
    func connectionStart() {
        connection.start()
    }
    
    private func handleMessage(_ message: String, from user: String) {
        // Do something with the message.
    }
}

extension SignalRService: HubConnectionDelegate {
    public func connectionDidOpen(hubConnection: SwiftSignalRClient.HubConnection) {
        print("connection did open")
    }
    
    public func connectionDidFailToOpen(error: any Error) {
        print("connectionDidFailToOpen")
    }
    
    public func connectionDidClose(error: (any Error)?) {
        print("connectionDidClose")
    }
    
    
}
