//
//  AdminProfileViewController.swift
//  Dezis
//
//  Created by Telegey Nurbekova on 26/09/24.
//

import UIKit

class AdminProfileViewController: UIViewController {
    
    private var profileDetails: [ProfileDetails] = [
        ProfileDetails(title: "Логин"),
        ProfileDetails(title: "Пароль"),
        ProfileDetails(title: "Имя пользователя")
    ]
    
    private let profileLabel: UILabel = {
        let view = UILabel()
        view.text = "Профиль"
        view.font = .systemFont(ofSize: 20)
        view.textColor = .init(UIColor(hex: "#000000"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let profileLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileDetailsTableView = UITableView()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hex: "#5191BA")
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileDetailsTableView.register(ProfileDetailsCell.self, forCellReuseIdentifier: "cell2")
        profileDetailsTableView.dataSource = self
        profileDetailsTableView.delegate = self
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
        view.addSubview(profileLabel)
        view.addSubview(profileLineView)
        view.addSubview(profileDetailsTableView)
        profileDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate(
            [
                profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                profileLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 12),
                
                profileLineView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 3),
                profileLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                profileLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                profileLineView.heightAnchor.constraint(equalToConstant: 1),
                
                profileDetailsTableView.topAnchor.constraint(equalTo: profileLineView.bottomAnchor, constant: 12),
                profileDetailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                profileDetailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                profileDetailsTableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
                
                saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
                saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                saveButton.widthAnchor.constraint(equalToConstant: 108),
                saveButton.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension AdminProfileViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProfileDetailsCell
        cell.setup(details: profileDetails[indexPath.row])
        return cell
    }
}

extension AdminProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
