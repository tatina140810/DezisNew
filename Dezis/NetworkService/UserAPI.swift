import Moya

enum UserApi {
    case userRegister(username: String, email: String, number: String, password: String, apartmentNumber: String, address: String)
    case verifyUser(email: String, otp: String)
    case getToken(email: String, password: String)
    case userLogin(email: String, password: String)
    case refreshToken(refreshToken: String)
    case booking (user: Int, service: String, date: String, time: String, is_completed: Bool)
    case userDetails (id: Int)
    case getUserProfile(email: String)
    case fetchProcessingOrders(clientId: Int)
    case logOut(email: String)
    case resendOtp (email: String)
    case forgotPassword(email: String)
    case updateUserInfo(userId: Int, parameters: [String: Any])
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
        case.userDetails(let id):
            return "/api/v1/user/list-user/\(id)/"
        case .getUserProfile(_):
            return "/api/v1/user/list-user/"
        case .fetchProcessingOrders(let clientId):
            return "/api/v1/contact/processing/\(clientId)/"
        case .logOut:
            return "/api/v1/user/logout-user/"
        case .resendOtp:
            return "/api/v1/user/resend-otp/"
        case .forgotPassword:
            return "/api/v1/user/forgot-password/"
        case .updateUserInfo(let userId, _):
            return "/api/v1/user/put-request/\(userId)/"
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
        case .userDetails:
            return .get
        case .getUserProfile:
            return .get
        case .fetchProcessingOrders:
            return .get
        case .logOut:
            return .post
        case .resendOtp:
            return .post
        case .forgotPassword:
            return .post
        case .updateUserInfo:
            return .put
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
                                                    "is_completed": false
                                                  ], encoding: JSONEncoding.default)
        case .userDetails(let id):
            return .requestPlain
            
        case .getUserProfile(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.default)
        case .fetchProcessingOrders:
            return .requestPlain
        case .logOut(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .resendOtp(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .forgotPassword(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        case .updateUserInfo(_, let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let token = KeychainService().accessToken
        
        switch self {
        case .userRegister(_,_,_,_,_,_):
            return [
                "Content-Type": "application/json"
            ]
        case .userLogin(_,_):
            return [
                "Content-Type": "application/json"
            ]
        case .verifyUser(_,_):
            return [
                "Content-Type": "application/json"
            ]
        case .booking(_,_,_,_,_):
            return [
                "Content-Type": "application/json"
            ]
        case .userDetails(id: _):
            return [
                "Content-Type": "application/json"
            ]
        case .forgotPassword:
            return [
                "Content-Type": "application/json"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
        
        
        var sampleData: Data {
            return Data()
        }
    }
}
