import Moya

enum UserApi {
    case news
    case userRegister(username: String, email: String, password: String, apartmentNumber: String, address: String)
    case getToken(username: String, password: String)
    case userLogin(email: String, password: String)
    case refreshToken(refreshToken: String)
}

extension UserApi: TargetType {
    
    var baseURL: URL { URL(string: "http://209.38.228.54:8084")! }
    
    var path: String {
        switch self {
        case .news:
            return "/api/v1/news/"
        case .userRegister:
            return "/api/v1/user/register-user/"
        case .userLogin:
            return "/api/v1/user/login-user/"
        case .getToken:
            return "/api/token/"
        case .refreshToken:
            return "/api/token/refresh/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .news:
            return .get
        case .getToken, .refreshToken, .userRegister:
            return .post
        case .userLogin:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getToken(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        case .refreshToken(let refreshToken):
            return .requestParameters(parameters: ["refresh": refreshToken], encoding: JSONEncoding.default)
        case .userRegister(let username, let email, let password, let apartmentNumber, let address):
            return .requestParameters(parameters: ["username": username, "email": email, "password": password, "apartment_number": apartmentNumber, "address": address], encoding: JSONEncoding.default)
        case .userLogin(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
            let token = KeychainService().accessToken
            switch self {
            case .getToken, .refreshToken, .userRegister, .userLogin:
                return ["Content-Type": "application/json"]
                
            case .news, .userLogin :
                if !token.isEmpty {
                    return ["Authorization": "Bearer\(token)", "Content-Type": "application/json"]
                } else {
                    return nil
                }
        }
    }
}