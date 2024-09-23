//
//  ClientHomeViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 20/9/24.
//

import UIKit

class ClientHomeViewController: UIViewController {
   
    private var infoTitleLabel = LabelSettings().labelMaker(text: "Ваша первая обработка")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
       setupUI()
    }
    
    func setupNavigationItems(){
        navigationController?.navigationBar.backgroundColor = UIColor(hex: "#5191BA")
        navigationController?.navigationBar.tintColor = .white
        let rightButton = UIBarButtonItem(image: UIImage(resource: .frame), style: .plain, target: self, action: #selector(rightButtonTapped))
                navigationItem.rightBarButtonItem = rightButton
        let leftButton = UIBarButtonItem(image: UIImage(resource: .image7), style: .plain, target: self, action: #selector(leftButtonTapped))
                navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func setupUI(){
        view.addSubview(infoTitleLabel)
        NSLayoutConstraint.activate([
            infoTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            infoTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)])
    }
    
    @objc func leftButtonTapped() {
           
            print("Left button tapped")
    }
    @objc func rightButtonTapped() {
        let vc = ClientChatViewController()
    navigationController?.pushViewController(vc, animated: true)
            // Действие при нажатии кнопки
            print("Right button tapped")
        }
    
}
