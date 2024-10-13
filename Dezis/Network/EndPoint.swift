//
//  EndPoint.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 19/9/24.
//

import Foundation
struct EndPoint{
    var path: String
}
extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "http://209.38.228.54/"
        components.port = 8084
        components.path = "/"
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension EndPoint {
    static var user: Self {
        EndPoint(path: "v1/user/")
    }
}
extension EndPoint {
    static var admin: Self {
        EndPoint(path: "admin")
    }
}

