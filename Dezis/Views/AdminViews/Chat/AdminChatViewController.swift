import UIKit
import SnapKit

class AdminChatViewController: UIViewController {
    
    private let backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "leftBtn"), for: .normal)
        return btn
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Чат"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Cообщения"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var messages: [String] = ["Duis aliquet fermentum",
                                      "Duis aliquet fermentum",
                                      "Duis aliquet fermentum",
                                      "Duis aliquet fermentum"]
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        setupConstraints()
        setupAddTarget()
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-21)
        }
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(24)
        }
        
        view.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(16)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupAddTarget(){
        backBtn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
    }
}

extension AdminChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell", for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.row]
        cell.configure(name: "Имя", message: message, time: "9:12 PM", isRead: indexPath.row == 2)
        return cell
    }
}

class ChatMessageCell: UITableViewCell {
    private let grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "user")
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "9:12"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check-square-blue")
        return view
    }()
    
    private let unreadCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.layer.cornerRadius = 9
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        //label.isHidden = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(grayLine)
        grayLine.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(50)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom).offset(16)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalTo(timeLabel.snp.left).offset(-5)
        }
        
        contentView.addSubview(unreadCountLabel)
        unreadCountLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(4)
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(18)
        }
        
    }
    
    func configure(name: String, message: String, time: String, isRead: Bool) {
        nameLabel.text = name
        messageLabel.text = message
        timeLabel.text = time
        checkmarkImageView.isHidden = !isRead
        unreadCountLabel.isHidden = isRead
    }
}
