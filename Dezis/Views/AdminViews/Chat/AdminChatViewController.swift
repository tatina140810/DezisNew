import UIKit
import SnapKit

class AdminChatViewController: UIViewController {
    
    private var chatAPI: ChatAPI!
      private var chats: [Chat] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Чаты"
        label.textColor = UIColor.white
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        view.separatorStyle = .none
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#1B2228")
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
        chatAPI = ChatAPI(token: KeychainService.shared.accessToken)
               fetchChats()
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(64)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func fetchChats() {
           chatAPI.fetchChats { [weak self] result in
               switch result {
               case .success(let chats):
                   self?.chats = chats
                   DispatchQueue.main.async {
                       self?.tableView.reloadData()
                   }
               case .failure(let error):
                   print("Error fetching chats: \(error)")
               }
           }
       }
}

extension AdminChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        cell.configure(userLogo: "chatUser", name: "User \(chat.user)", message: chat.messages.last?.text ?? "", time: chat.createdAt, checkmarkImage: "twoUnread", unreadCount: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

class ChatMessageCell: UITableViewCell {
    
    private let blueLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#0A84FF")
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "chatUser")
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = .white
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(hex: "#818C99")
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(hex: "#818C99")
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check-square-blue")
        return view
    }()
    
    private let unreadCountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(hex: "#0A84FF")
        label.layer.cornerRadius = 9
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let rightArrowBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "arrowRight"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .init(hex: "#2B373E")
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(blueLine)
        blueLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.bottom.equalToSuperview().offset(-11)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(52)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(profileImageView.snp.right).offset(12)
        }
        
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(messageLabel)
        checkmarkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(messageLabel)
            make.left.equalTo(profileImageView.snp.right).offset(13)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(11)
            make.left.equalTo(checkmarkImageView.snp.right).offset(3)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-35)
            make.top.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(unreadCountLabel)
        unreadCountLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.right.equalToSuperview().offset(-35)
            make.height.width.equalTo(18)
        }
        
        contentView.addSubview(rightArrowBtn)
        rightArrowBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func configure(userLogo: String, name: String, message: String, time: String, checkmarkImage: String, unreadCount: String?) {
        nameLabel.text = name
        messageLabel.text = message
        timeLabel.text = time
        checkmarkImageView.image = UIImage(named: checkmarkImage)

        if let unreadCount = unreadCount {
            unreadCountLabel.isHidden = false
            unreadCountLabel.text = unreadCount
        } else {
            unreadCountLabel.isHidden = true
        }
    }
}
