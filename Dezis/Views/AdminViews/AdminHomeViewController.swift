//
//  AdminHomeViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class AdminHomeViewController: UIViewController {
    
    private let calendarLabel: UILabel = {
        let view = UILabel()
        view.text = "Календарь"
        view.font = .boldSystemFont(ofSize: 22)
        view.textColor = .init(UIColor(hex: "#21252B"))
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
        setupUI()
    }
    
    private func setupNavigationItems(){
        navigationController?.navigationBar.backgroundColor = UIColor(hex: "#5191BA")
        navigationController?.navigationBar.tintColor = .white
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "chat"), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "logo"), style: .plain, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func setupUI(){
        view.addSubview(calendarLabel)
        NSLayoutConstraint.activate([
            calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            calendarLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    @objc func leftButtonTapped() {
        print("Left button tapped")
    }
    
    @objc func rightButtonTapped() {
        let vc = AdminChatViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
