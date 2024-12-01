
import UIKit
protocol IClientChatViewController: AnyObject {
  
}
class ClientChatViewController: UIViewController, IClientChatViewController {
    
    private var presenter: IClientChatPresenter?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        self.presenter = ClientChatPresenter(view: self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        setupConstraints()
        navigationControllerSettings()
        NotificationCenterSetup()
    }
    private func NotificationCenterSetup(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
         
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


@objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3
        
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = -keyboardHeight
        }
    }
}
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
}



@objc func keyboardWillHide(_ notification: Notification) {
    let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3

    UIView.animate(withDuration: duration) {
        self.view.frame.origin.y = 0
    }
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
        guard let list = presenter?.getChats() else {
            
            return 0
        }
        return list.count
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! CellForChat
            guard let list = presenter?.getChats() else {
                return cell
            }
            let messageData = list[indexPath.row]
            let isIncoming = indexPath.row % 2 == 0
            cell.configure(message: messageData.message, time: messageData.time, checkmark: messageData.checkmark, isIncoming: isIncoming)
            cell.backgroundColor = UIColor(hex: "#1B2228")
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return UITableView.automaticDimension
        }
        
    }
