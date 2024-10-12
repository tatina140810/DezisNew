//
//  ClientChatViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 22/9/24.
//

import UIKit

class ClientChatViewController: UIViewController {
    
    private lazy var navigationBarView: CustomNavigationBar = {
            let view = CustomNavigationBar()
            return view
        }()

        private lazy var tableView: UITableView = {
            let view = UITableView()
            view.register(CellForChat.self, forCellReuseIdentifier: "ChatCell")
            view.separatorStyle = .none
            view.backgroundColor = UIColor(hex: "#1B2228")
            return view
        }()
    private lazy var textField = TextFieldSettings().textFieldMaker(placeholder: "",  backgroundColor: UIColor(hex: "#161718"), cornerRadius: 16)
                                    
    private lazy var emodziImage: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(resource: .shape), for: .normal)
        return image
    }()
    
        
    let messages = [
        (message: "Здравствуйте!", time: "18:48", checkmark: UIImage(resource: .twoRead)),
        (message: "Здраствуйте! Все хорошо, как я могу расплатится?!", time: "18:49", checkmark: UIImage(resource: .twoRead)),
        (message: "Хорошо", time: "18:50", checkmark: UIImage(resource: .twoRead))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        setupConstraints()
        navigationControllerSettings()
    }
    private func navigationControllerSettings() {
        navigationController?.navigationBar.isUserInteractionEnabled = true
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = backButton
    }
    
        
        private func setupConstraints() {
            
            view.addSubview(navigationBarView)
            navigationBarView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(50)
                make.height.equalTo(50)
                make.width.equalTo(375)
            }
            view.addSubview(textField)
            textField.layer.borderColor = UIColor.white.cgColor
            textField.borderStyle = .line
            textField.layer.borderWidth = 1.0
            textField.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(32)
                make.bottom.equalToSuperview().offset(-90)
            }
            textField.addSubview(emodziImage)
            emodziImage.snp.makeConstraints { make in
                make.trailing.equalTo(textField.snp.trailing).offset(-10)
                make.height.width.equalTo(18)
                make.centerY.equalTo(textField)
            }
           
            view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.top.equalTo(navigationBarView.snp.bottom).offset(20)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(textField.snp.top).offset(-10)
            }
           
        }
    @objc func backButtonTapped(){
        let vc = ClientTabBarController()
        print("tapped")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    }
extension ClientChatViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! CellForChat
        let messageData = messages[indexPath.row]
        let isIncoming = indexPath.row % 2 == 0
        cell.configure(message: messageData.message, time: messageData.time, checkmark: messageData.checkmark, isIncoming: isIncoming)
        cell.backgroundColor = UIColor(hex: "#1B2228")

        return cell
    }
        
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         
            return UITableView.automaticDimension
        }
  
    }
    

   
