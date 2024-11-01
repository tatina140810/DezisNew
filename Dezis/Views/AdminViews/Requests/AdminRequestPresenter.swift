//
//  AdminRequestPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 24/10/24.
//

import UIKit

protocol IAdminRequestPresenter: AnyObject {
    func loadRequests()
    func loadUserRequest(userId: Int, completion: @escaping (UserInformation?) -> Void)
    func numberOfRequests() -> Int
    func requestAt(_ index: Int) -> UserInformation?
}

class AdminRequestPresenter: IAdminRequestPresenter {
    
    private var view: IAdminRequestView? = nil
    
    private let networkService = AdminNetworkService()
    
    private var requests: [UserInformation] = []
    
    required init(view: IAdminRequestView) {
        self.view = view
    }
    
    func loadRequests() {
        networkService.fetchRequests { [weak self] result in
            switch result {
            case .success(let requests):
                self?.requests = requests
                self?.view?.reloadData()
            case .failure(let error):
                print("Ошибка загрузки запросов: \(error)")
            }
        }
    }
    
    func loadUserRequest(userId: Int, completion: @escaping (UserInformation?) -> Void) {
        networkService.fetchUserDetails(userId: userId) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print("Ошибка получения данных пользователя: \(error)")
                completion(nil)
            }
        }
    }
    
    func numberOfRequests() -> Int {
        return requests.count
    }
    
    func requestAt(_ index: Int) -> UserInformation? {
        guard index < requests.count else { return nil }
        return requests[index]
    }
    
}

