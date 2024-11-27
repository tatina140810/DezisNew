//
//  AuthManager.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 26/11/24.
//

import Foundation
import JWTDecode
import Moya

final class AuthManager {
    
    let provider = MoyaProvider<UserApi>()
    
    static let shared = AuthManager()
    
    private init() {}
    
    func validateToken(completion: @escaping (Bool) -> Void) {
        guard KeychainService.shared.hasTokens() else {
            print("Нет токенов. Пользователь не авторизован.")
            completion(false)
            return
        }
        
        if isAccessTokenExpired() {
            print("Access Token истёк. Обновляем токен.")
            refreshAccessToken { success in
                completion(success)
            }
        } else {
            print("Access Token действителен.")
            completion(true)
        }
    }
    
    
    private func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        
        guard !KeychainService.shared.refreshToken.isEmpty else {
            print("Refresh Token отсутствует.")
            completion(false)
            return
        }
        
        provider.request(.refreshToken(refreshToken: KeychainService.shared.refreshToken)) { result in
            switch result {
            case .success(let response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: String]
                    if let newAccessToken = json?["access"],
                       let newRefreshToken = json?["refresh"] {
                        KeychainService.shared.saveToken(
                            token: UserTokenResponseModel(accessToken: newAccessToken, refreshToken: newRefreshToken)
                        )
                        print("Токен успешно обновлен.")
                        completion(true)
                    } else {
                        print("Ошибка: Некорректный ответ сервера.")
                        completion(false)
                    }
                } catch {
                    print("Ошибка декодирования ответа: \(error.localizedDescription)")
                    completion(false)
                }
                
            case .failure(let error):
                print("Ошибка запроса обновления токена: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    
    private func isAccessTokenExpired() -> Bool {
        let jwt = try? decode(jwt: KeychainService.shared.accessToken)
        if let jwt = jwt, let expiresAt = jwt.expiresAt {
            let jwtDate = Calendar.current.date(byAdding: .minute, value: -3, to: expiresAt) ?? Date()
            return jwtDate < Date()
        }
        return true
    }
}
