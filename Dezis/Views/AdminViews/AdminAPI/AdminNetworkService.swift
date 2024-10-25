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
                let jsonString = String(data: response.data, encoding: .utf8) ?? "Нет данных"
                print("Полученные данные: \(jsonString)")
                
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
                completion(.failure(error))
            }
        }
    }
    
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        provider.request(.fetchOrders) { result in
            switch result {
            case .success(let response):
                print("Response status code: \(response.statusCode)")
                do {
                    let orders = try JSONDecoder().decode([Order].self, from: response.data)
                    completion(.success(orders))
                } catch {
                    print("Ошибка декодирования: \(error)")
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
