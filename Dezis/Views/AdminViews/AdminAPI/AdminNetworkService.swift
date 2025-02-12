//
//  AdminNetworkService.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 22/10/24.
//

import Foundation
import Moya

struct AdminLoginResponse: Codable {
    let detail: String
    let tokens: Tokens
}

struct Tokens: Codable {
    let refresh: String
    let access: String
}

struct AdminErrorResponse: Codable {
    let detail: String
}

struct Order: Codable {
    let id: Int
    let user: Int
    let service: String
    let date: String
    let time: String
    let is_completed: Bool
}

extension Order {
    func dateTime() -> Date? {
        let dateTimeString = "\(date) \(time)"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = formatter.date(from: dateTimeString) {
            return date
        } else {
            print("Ошибка преобразования для строки: \(dateTimeString)")
            return nil
        }
    }
}

struct UserInformation: Codable {
    let id: Int
    let username: String?
    let apartment_number: String?
    let email: String?
    let number: String?
    let address: String?
    let avatar: String?
    let is_confirmed: Bool
    let created_at: String?
}

class AdminNetworkService {
    
    private let provider = MoyaProvider<AdminApi>(requestClosure: { (endpoint, closure) in
        var request = try! endpoint.urlRequest()
        request.timeoutInterval = 30
        closure(.success(request))
    })
    
    func loginAdmin(login: String, password: String, completion: @escaping (Result<AdminLoginResponse, Error>) -> Void) {
        provider.request(.loginAdmin(login: login, password: password)) { result in
            switch result {
            case .success(let response):
                print("Response status code: \(response.statusCode)")
                
                do {
                    guard (200...299).contains(response.statusCode) else {
                        let errorResponse = try JSONDecoder().decode(AdminErrorResponse.self, from: response.data)
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.detail])))
                        return
                    }
                    
                    let adminResponse = try JSONDecoder().decode(AdminLoginResponse.self, from: response.data)
                    completion(.success(adminResponse))
                } catch {
                    print("Ошибка декодирования: \(error)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print("Ошибка сети: \(error)")
                if let response = error.response {
                    print("Ответ сервера: \(String(data: response.data, encoding: .utf8) ?? "Нет данных")")
                }
                completion(.failure(error))
                
            }
        }
    }
    
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        provider.request(.fetchOrders) { result in
            switch result {
            case .success(let response):
                do {
                    let orders = try JSONDecoder().decode([Order].self, from: response.data)
                    completion(.success(orders))
                } catch {
                    print("Ошибка декодирования: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Ошибка сети: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchUserDetails(userId: Int, completion: @escaping (Result<UserInformation, Error>) -> Void) {
        provider.request(.fetchUserDetails(userId: userId)) { result in
            switch result {
            case .success(let response):
                do {
                    let users = try JSONDecoder().decode([UserInformation].self, from: response.data)
                    
                    if let userDetails = users.first(where: { $0.id == userId }) {
                        completion(.success(userDetails))
                    } else {
                        
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"])))
                    }
                } catch {
                    print("Ошибка декодирования пользователя: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Ошибка сети: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func fetchRequests(completion: @escaping (Result<[UserInformation], Error>) -> Void) {
        provider.request(.fetchRequests) { result in
            switch result {
            case .success(let response):
                do {
                    if let responseString = String(data: response.data, encoding: .utf8) { }
                    
                    let requests = try JSONDecoder().decode([UserInformation].self, from: response.data)
                    completion(.success(requests))
                } catch {
                    print("Ошибка декодирования запросов: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Ошибка сети: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func completeOrder(orderId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.completeOrder(orderId: orderId)) { result in
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    completion(.success(()))
                } else {
                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to complete order."])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func confirmUser(userId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.confirmUser(userId: userId)) { result in
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    completion(.success(()))
                } else {
                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to confirm user."])))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteUser(userId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.deleteUser(userId: userId)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 204 {
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed to delete user."])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
