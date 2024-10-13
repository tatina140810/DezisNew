//
//  NetworkRequest.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 19/9/24.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    let endPoint = EndPoint(path: "/v1/chat/")
   
    private init() {}
    
    func getData(completionHandler: @escaping (Result<Data, NetworkError>) -> Void)  {
          
      let url = endPoint.url
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
       
        URLSession.shared.dataTask(with: request) { data, response, error in
                  
                   if let error = error {
                       print("Error:", error.localizedDescription)
                       completionHandler(.failure(.networkFailed))
                       return
                   }
                   
                  
                   if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                       completionHandler(.failure(.serverError(statusCode: httpResponse.statusCode)))
                       return
                   }
                   
                 
                   guard let data = data else {
                       completionHandler(.failure(.noData))
                       return
                   }
               
                completionHandler(.success(data))
            }.resume()
        }
    }
