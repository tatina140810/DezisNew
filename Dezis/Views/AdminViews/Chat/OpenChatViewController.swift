////
////  OpenChatViewController.swift
////  Dezis
////
////  Created by Alexey Lim on 9/10/24.
////
//
//import UIKit
//import SnapKit
//
//class OpenChatViewController: UIViewController {
//    
//    private var chatWebSocket: ChatWebSocket!
//    
//    private lazy var backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Назад", for: .normal)
//        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 17)
//        button.tintColor = .init(hex: "0A84FF")
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private let chatTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Ishenbekov Bektur"
//        label.textColor = UIColor.white
//        label.font = UIFont(name: "SFProDisplay-Bold", size: 17)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    private let chatUserImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "chatUser")
//        imageView.layer.cornerRadius = 8
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//    
//    private let messageDateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Fri, Jul 26"
//        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
//        label.textColor = .init(hex: "3C3C43")
//        label.textAlignment = .center
//        label.backgroundColor = .init(hex: "DDDDE9")
//        label.layer.cornerRadius = 8
//        label.clipsToBounds = true
//        return label
//    }()
//    
//    private let tableView: UITableView = {
//        let view = UITableView()
//        view.register(UserMessageCell.self, forCellReuseIdentifier: "UserMessageCell")
//        view.register(AdminMessageCell.self, forCellReuseIdentifier: "AdminMessageCell")
//        view.separatorStyle = .none
//        view.backgroundColor = .clear
//        return view
//    }()
//    
//    private let messageInputTextField: UITextField = {
//        let textField = UITextField()
//        //textField.placeholder = "Сообщение..."
//        textField.textColor = .white
//        textField.backgroundColor = UIColor(hex: "#161718")
//        textField.layer.cornerRadius = 16
//        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
//        textField.leftViewMode = .always
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.white.cgColor
//        return textField
//    }()
//    
//    private lazy var sendMessageButton: UIButton = {
//        let button = UIButton(type: .system)
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
//        let image = UIImage(named: "stickers")
//        button.setImage(image, for: .normal)
//        button.tintColor = UIColor(hex: "0A84FF")
//        button.addTarget(self, action: #selector(sendMessageButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private var messages: [(isUserMessage: Bool, message: String, time: String)] = [
//        (isUserMessage: false, message: "Здравствуйте!", time: "10:10"),
//        (isUserMessage: false, message: "Доброе утро!", time: "10:10"),
//        (isUserMessage: false, message: "C вас 15000 сом", time: "10:10"),
//        (isUserMessage: true, message: "Здравствуйте! Все хорошо, как я могу расплатится?", time: "11:45"),
//    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupConstraints()
//        tableView.delegate = self
//        tableView.dataSource = self
//        chatWebSocket = ChatWebSocket()
//        chatWebSocket.connect()
//    }
//    
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    @objc private func sendMessageButtonTapped() {
//         guard let messageText = messageInputTextField.text, !messageText.isEmpty else { return }
//         
//         chatWebSocket.sendMessage(text: messageText)
//         // Добавьте отправленное сообщение в массив `messages` и обновите `tableView`
//         messages.append((isUserMessage: true, message: messageText, time: getCurrentTime()))
//         tableView.reloadData()
//         messageInputTextField.text = ""
//     }
//
//     // Вспомогательная функция для получения текущего времени
//     private func getCurrentTime() -> String {
//         let dateFormatter = DateFormatter()
//         dateFormatter.dateFormat = "HH:mm"
//         return dateFormatter.string(from: Date())
//     }
//    
//    private func setupUI() {
//        view.backgroundColor = .init(hex: "#1B2228")
//        
//        view.addSubview(backButton)
//        view.addSubview(chatTitleLabel)
//        view.addSubview(chatUserImage)
//        view.addSubview(messageDateLabel)
//        view.addSubview(tableView)
//        view.addSubview(messageInputTextField)
//        view.addSubview(sendMessageButton)
//    }
//    
//    private func setupConstraints() {
//        backButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(54)
//            make.left.equalToSuperview().offset(28)
//        }
//        
//        chatUserImage.snp.makeConstraints { make in
//            make.centerY.equalTo(backButton)
//            make.left.equalTo(backButton.snp.right).offset(15)
//            make.width.height.equalTo(36)
//        }
//        
//        chatTitleLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(backButton)
//            make.left.equalTo(chatUserImage.snp.right).offset(10)
//        }
//        
//        messageDateLabel.snp.makeConstraints { make in
//            make.top.equalTo(chatUserImage.snp.bottom).offset(8)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(21)
//            make.width.equalTo(100)
//        }
//        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(messageDateLabel.snp.bottom).offset(9)
//            make.left.right.equalToSuperview()
//            make.bottom.equalTo(messageInputTextField.snp.top).offset(-16)
//        }
//        
//        messageInputTextField.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.bottom.equalToSuperview().offset(-34)
//            make.height.equalTo(32)
//            make.right.equalToSuperview().offset(-20)
//        }
//        
//        messageInputTextField.addSubview(sendMessageButton)
//        sendMessageButton.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-10)
//        }
//    }
//}
//
//extension OpenChatViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let messageData = messages[indexPath.row]
//        
//        if messageData.isUserMessage {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMessageCell", for: indexPath) as! UserMessageCell
//            cell.configure(message: messageData.message, time: messageData.time)
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AdminMessageCell", for: indexPath) as! AdminMessageCell
//            cell.configure(message: messageData.message, time: messageData.time)
//            return cell
//        }
//    }
//}
//
//// MARK: - Message Cells
//
//class UserMessageCell: UITableViewCell {
//    
//    private let messageBackground: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(hex: "#FAFAFA")
//        view.layer.cornerRadius = 8
//        return view
//    }()
//    
//    private let messageLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
//        label.textColor = .black
//        label.numberOfLines = 0
//        label.textAlignment = .left
//        return label
//    }()
//    
//    private let timeLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "SFProDisplay-Regular", size: 11)
//        label.textColor = UIColor(hex: "#000000")
//        return label
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .clear
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupConstraints() {
//        contentView.addSubview(messageBackground)
//        messageBackground.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(4)
//            make.bottom.equalToSuperview()
//            make.left.equalToSuperview().offset(16)
//            make.right.lessThanOrEqualToSuperview().offset(-60)
//        }
//        
//        messageBackground.addSubview(messageLabel)
//        messageLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(8)
//            make.bottom.equalToSuperview().offset(-8)
//            make.left.equalToSuperview().offset(8)
//            make.right.equalToSuperview().offset(-8)
//        }
//        
//        contentView.addSubview(timeLabel)
//        timeLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(messageBackground).offset(-6)
//            make.right.equalTo(messageBackground).offset(-8)
//        }
//    }
//    
//    func configure(message: String, time: String) {
//        messageLabel.text = message
//        timeLabel.text = time
//    }
//}
//
//class AdminMessageCell: UITableViewCell {
//    
//    private let messageBackground: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(hex: "2B373E")
//        view.layer.cornerRadius = 10
//        return view
//    }()
//    
//    private let messageLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
//        label.textColor = .white
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    private let timeLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
//        label.textColor = UIColor(hex: "FFFFFF")
//        return label
//    }()
//    
//    private let checkmarkImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "twoRead")
//        imageView.tintColor = .white
//        return imageView
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .clear
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupConstraints() {
//        contentView.addSubview(messageBackground)
//        messageBackground.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(4)
//            make.bottom.equalToSuperview()
//            make.right.equalToSuperview().offset(-16)
//            make.left.greaterThanOrEqualToSuperview().offset(60)
//        }
//        
//        messageBackground.addSubview(messageLabel)
//        messageLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(8)
//            make.bottom.equalToSuperview().offset(-10)
//            make.left.equalToSuperview().offset(5)
//            make.right.equalToSuperview().offset(-76)
//        }
//        
//        messageBackground.addSubview(checkmarkImageView)
//        messageBackground.addSubview(timeLabel)
//        
//        checkmarkImageView.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-7)
//            make.bottom.equalToSuperview().offset(-9)
//        }
//        
//        timeLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(checkmarkImageView)
//            make.right.equalTo(checkmarkImageView.snp.left).offset(-4)
//        }
//    }
//    
//    func configure(message: String, time: String) {
//        messageLabel.text = message
//        timeLabel.text = time
//    }
//}
//
//
//
