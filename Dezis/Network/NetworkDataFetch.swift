//
//  NetworkDataFetch.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 19/9/24.
//

import Foundation
class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fetchUsers(response: @escaping ([User?], NetworkError) -> Void) {
        
        
    }
}
