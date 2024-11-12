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
    func confirmUser(at index: Int, completion: @escaping (Bool) -> Void)
    func denyUser(at index: Int, completion: @escaping (Bool) -> Void)
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
                self?.requests = requests.filter { !$0.is_confirmed }.sorted { $0.id > $1.id }
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
    
    func confirmUser(at index: Int, completion: @escaping (Bool) -> Void) {
        guard index < requests.count else { return }
        
        let userId = requests[index].id
        networkService.confirmUser(userId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.requests.remove(at: index)
                completion(true)
                self?.view?.reloadData() 
            case .failure(let error):
                print("Ошибка подтверждения пользователя: \(error)")
                completion(false)
            }
        }
    }
    
    func denyUser(at index: Int, completion: @escaping (Bool) -> Void) {
        guard index < requests.count else { return }
        
        let userId = requests[index].id
        networkService.deleteUser(userId: userId) { [weak self] result in
            switch result {
            case .success:
                self?.requests.remove(at: index)
                completion(true)
                self?.view?.reloadData()
            case .failure(let error):
                print("Ошибка удаления пользователя: \(error)")
                completion(false)
            }
        }
    }
}

