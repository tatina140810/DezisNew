
import UIKit
import Foundation
import JWTDecode
import KeychainSwift

struct UserTokenResponseModel {
    let accessToken: String
    let refreshToken: String
}


func isAccessTokenExpired() -> Bool {
        let jwt = try? decode(jwt: KeychainService.shared.accessToken)
        if let jwt = jwt, let expired = jwt.expiresAt {
            let jwtDate = Calendar.current.date(byAdding: .minute, value: -3, to: expired) ?? Date()
            let date = Date()
            return jwtDate < date
        } else {
            return false
        }
        
    }

final class KeychainService {
    
    static let shared = KeychainService()
    
    private var provider: KeychainSwift {
        let i = KeychainSwift()
        i.synchronizable = true
        return i
    }
    
    // MARK: - Token
    
    var accessToken: String {
        get {
            provider.get("access_token") ?? ""
        }
        set {
            provider.set(newValue, forKey: "access_token")
        }
    }
    
    var refreshToken: String {
        get {
            provider.get("refresh_token") ?? ""
        }
        set {
            provider.set(newValue, forKey: "refresh_token")
        }
    }
    
    func saveToken(token: UserTokenResponseModel?) {
        if let token = token {
            accessToken = token.accessToken
            refreshToken = token.refreshToken
        }
    }
    
    var hasToken: Bool {
        return self.accessToken != "" &&  self.accessToken != ""
    }
    
    func deleteAll() {
        provider.clear()
    }
}
