import Moya

enum APIService {
    case news
    case contact
    case user
    case chat
    case aboutUs
    case getToken(username: String, password: String)
    case refreshToken(refreshToken: String)
}

extension APIService: TargetType {
    
    var baseURL: URL { URL(string: "")! }
    
    var path: String {
        switch self {
        case .news:
            return "/api/v1/news/"
        case .contact:
            return "/api/v1/contact/"
        case .user:
            return "/api/v1/user/"
        case .chat:
            return "/api/v1/chat/"
        case .aboutUs:
            return "/api/v1/about_us/"
        case .getToken:
            return "/api/token/"
        case .refreshToken:
            return "/api/token/refresh/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .news, .contact, .user, .chat, .aboutUs:
            return .get
        case .getToken, .refreshToken:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getToken(let username, let password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
        case .refreshToken(let refreshToken):
            return .requestParameters(parameters: ["refresh": refreshToken], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getToken, .refreshToken:
            return ["Content-Type": "application/json"]
        default:
            guard let token = NetworkServiceViewController().accessToken else { return nil }
            return ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
