//
//  ServicesViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 20/9/24.
//

import UIKit

class ServicesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
    }
    func setupNavigationItems(){
        navigationController?.navigationBar.backgroundColor = UIColor(hex: "#5191BA")
        navigationController?.navigationBar.tintColor = .white
        let leftButton = UIBarButtonItem(image: UIImage(resource: .image7), style: .plain, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    @objc func leftButtonTapped() {
        // Действие при нажатии кнопки
        print("Left button tapped")
    }
    
}
