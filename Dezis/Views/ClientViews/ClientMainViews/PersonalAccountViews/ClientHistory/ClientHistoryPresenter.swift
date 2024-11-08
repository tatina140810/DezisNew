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
    private var view: IClientHistoryViewController?

    init(view: IClientHistoryViewController) {
        self.view = view
    }
    
    func fetchClientOrders() {
        guard let clientId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("Error: User Id not found in UserDefaults.")
            return
        }
        
        print("Fetching user details for clientId: \(clientId)")
        
        networkService.userDetails(id: clientId) { [weak self] result in
            switch result {
            case .success(let userProfile):
                print("User details fetched successfully: \(userProfile)")
                self?.userDetails = userProfile
                self?.fetchOrders(for: clientId)
            case .failure(let error):
                print("Failed to fetch user details: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchOrders(for clientId: Int) {
        print("Fetching orders for clientId: \(clientId)")
        
        networkService.fetchClientOrders { [weak self] result in
            switch result {
            case .success(let orders):
                print("Fetched \(orders.count) orders")
                self?.clientOrders = orders.filter { $0.user == clientId }
                self?.view?.reloadData()
                print("Filtered orders count: \(self?.clientOrders.count ?? 0)")
            case .failure(let error):
                print("Failed to fetch orders: \(error.localizedDescription)")
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
