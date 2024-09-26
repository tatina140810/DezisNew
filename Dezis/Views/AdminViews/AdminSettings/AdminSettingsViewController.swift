//
//  AdminSettingsViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class AdminSettingsViewController: UIViewController {
    
    private var settings: [Setting] = [
        Setting(title: "Темная тема", type: .withSwitch),
        Setting(title: "Язык:", type: .withRightBtn)]

    
    private let settingsLabel: UILabel = {
        let view = UILabel()
        view.text = "Настройки"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let settingsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let settingsTableView = UITableView()
    
    private let separationLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить аккаунт", for: .normal)
        button.setTitleColor(.init(hex: "#FA0000"), for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: "cell")
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        setupNavigationItems()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupNavigationItems(){
        navigationController?.navigationBar.tintColor = .black
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftButton.tintColor = .black
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func setupSubviews() {
        view.addSubview(settingsLabel)
        view.addSubview(settingsLineView)
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separationLineView)
        view.addSubview(deleteAccountButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                settingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                settingsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 12),
                
                settingsLineView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 3),
                settingsLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                settingsLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                settingsLineView.heightAnchor.constraint(equalToConstant: 1),
                
                settingsTableView.topAnchor.constraint(equalTo: settingsLineView.bottomAnchor, constant: 2),
                settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                settingsTableView.bottomAnchor.constraint(equalTo: separationLineView.topAnchor, constant: -10),
                
                deleteAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
                deleteAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteAccountButton.widthAnchor.constraint(equalToConstant: 147),
                
                separationLineView.bottomAnchor.constraint(equalTo: deleteAccountButton.topAnchor, constant: -3),
                separationLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                separationLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                separationLineView.heightAnchor.constraint(equalToConstant: 1),
                
                
            ])
    }
    
    @objc private func backButtonTapped() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func settingsTapped() {
        print("Settings label tapped")
    }
    
    @objc private func logOutTapped() {
        print("Log out tapped")
    }
}

extension AdminSettingsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCell
        cell.setup(settings: settings[indexPath.row])
        return cell
    }
}

extension AdminSettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
