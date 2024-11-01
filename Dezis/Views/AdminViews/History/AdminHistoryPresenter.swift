//
//  AdminHistoryPresenter.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 23/10/24.
//
import UIKit

struct CategoryModel {
    let categoryName: String
}

protocol IAdminHistoryPresenter: AnyObject {
    
    func didSelectCategory(at index: Int)
    func getCategories() -> [CategoryModel]
    func numberOfOrders() -> Int
    func orderAt(_ index: Int) -> Order
    func fetchOrders()
    func completeOrder(at index: Int)
    func numberOfCompletedOrders()  -> Int
    func completedOrderAt(_ index: Int)  -> Order
    func userDetails(for userId: Int) -> UserInformation?
}

class AdminHistoryPresenter: IAdminHistoryPresenter {
    
    private var view: IAdminHistoryView? = nil
    private let networkService = AdminNetworkService()
    
    private var orders: [Order] = []
    private var completedOrders: [Order] = []
    private var userDetailsCache: [Int: UserInformation] = [:]
    
    private var categories: [CategoryModel] = [
        CategoryModel(categoryName: "Новые заказы"),
        CategoryModel(categoryName: "Завершенные")
    ]
    
    private var selectedCategoryIndex = 0
    
    required init(view: IAdminHistoryView) {
        self.view = view
    }
    
//    func fetchOrders() {
//        networkService.fetchOrders { [weak self] result in
//            switch result {
//            case .success(let orders):
//                print("Заказы получены: \(orders)")
//                self?.orders = orders
//                self?.view?.reloadData()
//            case .failure(let error):
//                print("Не удалось получить заказы: \(error)")
//            }
//        }
//    }
    
    func fetchOrders() {
        networkService.fetchOrders { [weak self] result in
            switch result {
            case .success(let orders):
                print("Заказы получены: \(orders)")
                self?.orders = orders
                self?.fetchUserDetailsForOrders(orders)
            case .failure(let error):
                print("Не удалось получить заказы: \(error)")
            }
        }
    }
    
    private func fetchUserDetailsForOrders(_ orders: [Order]) {
        let userIds = Set(orders.map { $0.user })
        let dispatchGroup = DispatchGroup()
        
        for userId in userIds {
            dispatchGroup.enter()
            networkService.fetchUserDetails(userId: userId) { [weak self] result in
                switch result {
                case .success(let userDetails):
                    self?.userDetailsCache[userId] = userDetails
                case .failure(let error):
                    print("Ошибка получения данных пользователя с id \(userId): \(error)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.reloadData()
        }
    }

    func userDetails(for userId: Int) -> UserInformation? {
        return userDetailsCache[userId]
    }
    
    func didSelectCategory(at index: Int) {
        selectedCategoryIndex = index
        view?.updateCollectionViewVisibility(forCategory: selectedCategoryIndex)
        view?.reloadData()
    }
    
    func getCategories() -> [CategoryModel] {
        return categories
    }
    
    func numberOfOrders() -> Int {
        return orders.count
    }
    
    func orderAt(_ index: Int) -> Order {
        return orders[index]
    }
    
    func completeOrder(at index: Int) {
        guard index < orders.count else { return }
        
        let completedOrder = orders[index]
        completedOrders.append(completedOrder)
        orders.remove(at: index)
        view?.reloadData()
    }
    
    func numberOfCompletedOrders() -> Int {
        return completedOrders.count
    }
    
    func completedOrderAt(_ index: Int) -> Order {
        return completedOrders[index]
    }
}
