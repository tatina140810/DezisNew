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
}

extension AdminApi: TargetType {
    var baseURL: URL { URL(string: "http://209.38.228.54:8084")! }
    
    var path: String {
        switch self {
        case .loginAdmin:
            return "/api/v1/user/login-manager/"
        case .fetchOrders:
            return "/api/v1/contact/booking/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loginAdmin:
            return .post
        case .fetchOrders:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .loginAdmin(let login, let password):
            return .requestParameters(parameters: ["login": login, "password": password], encoding: JSONEncoding.default)
        case .fetchOrders:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
