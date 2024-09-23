//
//  NetworkRequest.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 19/9/24.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    func getData(completionHandler: @escaping (Result<Data, NetworkError>) -> Void)  {
        
        }
        
    }
