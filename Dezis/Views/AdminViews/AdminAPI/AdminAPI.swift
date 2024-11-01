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
            return "/api/v1/user/list-user/1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginAdmin:
            return .post
        case .fetchOrders, .fetchUserDetails, .fetchRequests:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .loginAdmin(let login, let password):
            return .requestParameters(parameters: ["login": login, "password": password], encoding: JSONEncoding.default)
        case .fetchOrders, .fetchUserDetails, .fetchRequests:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
