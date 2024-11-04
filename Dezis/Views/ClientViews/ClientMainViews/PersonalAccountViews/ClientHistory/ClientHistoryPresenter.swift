//
//  ClientHistoryPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 24/10/24.
//

import UIKit

protocol IClientHistoryPresenter: AnyObject {
    func fetchClientOrders()
    func numberOfClientOrders() -> Int
    func clientOrderAt(_ index: Int) -> Order
    func getUserDetails() -> UserProfile?
}

class ClientHistoryPresenter: IClientHistoryPresenter {
    
    private let networkService = UserNetworkService()
    private var clientOrders: [Order] = []
    private var userDetails: UserProfile?
    private var view: IClientHistoryViewController? = nil

    init(view: IClientHistoryViewController) {
        self.view = view
    }
    
    func fetchClientOrders() {
        guard let clientId = UserDefaults.standard.value(forKey: "userID") as? Int else {
            print("Error: User ID not found in UserDefaults.")
            return
        }

        networkService.user(id: clientId) { [weak self] result in
            switch result {
            case .success(let UserProfile):
                self?.userDetails = UserProfile
                self?.fetchOrders(for: clientId)
            case .failure(let error):
                print("Failed to fetch user details: \(error)")
            }
        }
    }
    
    private func fetchOrders(for clientId: Int) {
        networkService.fetchClientOrders { [weak self] result in
            switch result {
            case .success(let orders):
                self?.clientOrders = orders.filter { $0.user == clientId }
                self?.view?.reloadData()
            case .failure(let error):
                print("Failed to fetch orders: \(error)")
            }
        }
    }

    func numberOfClientOrders() -> Int {
        return clientOrders.count
    }
    
    func clientOrderAt(_ index: Int) -> Order {
        return clientOrders[index]
    }
    
    func getUserDetails() -> UserProfile? {
        return userDetails
    }
}
