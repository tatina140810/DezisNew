import Moya

enum UserApi {
    case userRegister(username: String, email: String, number: String, password: String, apartmentNumber: String, address: String)
    case verifyUser(email: String, otp: String)
    case getToken(email: String, password: String)
    case userLogin(email: String, password: String)
    case refreshToken(refreshToken: String)
    case booking (user: Int, service: String, date: String, time: String, is_completed: Bool)
    case user (id: Int)
    case getUserProfile(email: String)
    case fetchClientOrders
}

extension UserApi: TargetType {
    
    var baseURL: URL { URL(string: "https://dezis.pp.ua")! }
    
    var path: String {
        switch self {
        case .userRegister:
            return "/api/v1/user/register-user/"
        case .verifyUser:
            return "/api/v1/user/verify-user/"
        case .userLogin:
            return "/api/v1/user/login-user/"
        case .getToken:
            return "/api/token/"
        case .refreshToken:
            return "/api/token/refresh/"
        case .booking:
            return "/api/v1/contact/booking/"
        case.user(let id):
            return "/api/v1/user/list-user/\(id)"
        case .getUserProfile(_):
            return "/api/v1/user/list-user/"
        case .fetchClientOrders:
            return "/api/v1/contact/booking/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getToken, .refreshToken, .userRegister:
            return .post
        case .verifyUser:
            return .post
        case .userLogin:
            return .post
        case .booking:
            return .post
        case .user:
            return .get
        case .getUserProfile:
            return .get
        case .fetchClientOrders:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getToken(let email, let password):
            return .requestParameters(parameters: ["email": email, 
                                                   "password": password],
                                      encoding: JSONEncoding.default)
        case .refreshToken(let refreshToken):
            return .requestParameters(parameters: ["refresh": refreshToken], encoding: JSONEncoding.default)
        case .userRegister(let username, let email, let number, let password, let apartmentNumber, let address):
            return .requestParameters(parameters: ["username": username,
                                                   "email": email,
                                                   "apartment_number": apartmentNumber,
                                                   "address": address,
                                                   "password": password,
                                                   "number": number],
                                      encoding: JSONEncoding.default)
        case .verifyUser(let email, let otp):
            return .requestParameters(parameters: ["email": email,
                                                   "otp": otp],
                                      encoding: JSONEncoding.default)
            
        case .userLogin(let email, let password):
            return .requestParameters(parameters: ["email": email,
                                                   "password": password], 
                                      encoding: JSONEncoding.default)
        case .booking(let user, let service, let date, let time, _):
            return .requestParameters(parameters: [ "user": user,
                                                    "service": service,
                                                    "date": date,
                                                    "time": time,
                                                    "is_completed": true
                                                  ], encoding: JSONEncoding.default)
        case .user(let id):
            return .requestParameters(parameters: ["id": id], encoding: JSONEncoding.default)
        case .getUserProfile(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.default)
        case .fetchClientOrders:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
//            let token = KeychainService().accessToken
//            switch self {
//            case .getToken, .refreshToken, .userRegister, .userLogin:
            return ["Content-Type": "application/json"]
                }
                
    var sampleData: Data {
            return Data()
        }
}
