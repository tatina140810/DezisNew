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
}

class AdminHistoryPresenter: IAdminHistoryPresenter {

    private var view: IAdminHistoryView? = nil
    private let networkService = AdminNetworkService()
    
    private var orders: [Order] = []
    
    private var categories: [CategoryModel] = [
        CategoryModel(categoryName: "Новые заказы"),
        CategoryModel(categoryName: "Завершенные")
    ]
    
    private var selectedCategoryIndex = 0

    required init(view: IAdminHistoryView) {
        self.view = view
    }

    func viewDidLoad() {
        fetchOrders()
    }

    private func fetchOrders() {
        networkService.fetchOrders { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orders = orders
                self?.view?.reloadData()
            case .failure(let error):
                print("Failed to fetch orders: \(error)")
            }
        }
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
}
