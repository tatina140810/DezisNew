//
//  NetworkError.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 19/9/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkFailed
    case serverError(statusCode: Int)
    case noData
}
