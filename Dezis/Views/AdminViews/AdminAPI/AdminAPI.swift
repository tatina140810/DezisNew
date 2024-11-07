//
//  AdminAPI.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 22/10/24.
//

import Moya

enum AdminApi {
    case loginAdmin(login: String, password: String)
    case fetchOrders
    case fetchUserDetails(userId: Int)
    case fetchRequests
    case fetchDocumentation
    case completeOrder(orderId: Int)
    case confirmUser(userId: Int)
    case deleteUser(userId: Int)
}

extension AdminApi: TargetType {
    var baseURL: URL { URL(string: "https://dezis.pp.ua")! }
    
    var path: String {
        switch self {
        case .loginAdmin:
            return "/api/v1/user/login-manager/"
        case .fetchOrders:
            return "/api/v1/contact/booking/"
        case .fetchUserDetails(let userId):
            return "/api/v1/user/list-user/\(userId)"
        case . fetchRequests:
            return "/api/v1/user/inactive-users/"
        case .fetchDocumentation:
            return "/api/v1/about_us/documentations/"
        case .completeOrder(let orderId):
            return "/api/v1/contact/bookings/\(orderId)/complete/"
        case .confirmUser(let userId):
            return "/api/v1/user/put-request/\(userId)/"
        case .deleteUser(let userId):
            return "/api/v1/user/delete-user/\(userId)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginAdmin:
            return .post
        case .fetchOrders, .fetchUserDetails, .fetchRequests, .fetchDocumentation:
            return .get
        case .completeOrder, .confirmUser:
            return .put
        case .deleteUser:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .loginAdmin(let login, let password):
            return .requestParameters(parameters: ["login": login, "password": password], encoding: JSONEncoding.default)
        case .fetchOrders, .fetchUserDetails, .fetchRequests, .fetchDocumentation, .deleteUser:
            return .requestPlain
        case .completeOrder:
            return .requestJSONEncodable(["is_completed": true])
        case .confirmUser:
            return .requestJSONEncodable(["is_active": true])
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
