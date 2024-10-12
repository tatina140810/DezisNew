import UIKit
import SnapKit

class CellForChat: UITableViewCell {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let bubbleBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor =  UIColor(hex: "#2B373E")
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    var isIncoming: Bool = false {
        didSet {
            bubbleBackgroundView.backgroundColor = isIncoming ? UIColor.white : UIColor(hex: "#2B373E")
            messageLabel.textColor = isIncoming ? UIColor.black : UIColor(hex: "#2B373E")
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear 
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(bubbleBackgroundView)
        
        // Настройка самого пузырька
        bubbleBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.75)
            
            if isIncoming {
                make.leading.equalToSuperview().offset(16)
                make.trailing.lessThanOrEqualToSuperview().offset(-60)
            } else {
                make.trailing.equalToSuperview().offset(-16)
                make.leading.greaterThanOrEqualToSuperview().offset(60)
            }
        }
        
        // Добавление messageLabel
        bubbleBackgroundView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(bubbleBackgroundView.snp.top).offset(8)
            make.leading.equalTo(bubbleBackgroundView.snp.leading).offset(16)
            make.bottom.equalTo(bubbleBackgroundView.snp.bottom).offset(-8)
        }

        // Добавление timeLabel
        bubbleBackgroundView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(messageLabel.snp.trailing).offset(8)
            
            make.bottom.equalTo(bubbleBackgroundView.snp.bottom).offset(-8)
        }

        // Добавление checkmarkImageView
        bubbleBackgroundView.addSubview(checkmarkImageView)
        checkmarkImageView.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.trailing).offset(8)
            make.trailing.equalTo(bubbleBackgroundView.snp.trailing).offset(-8)
            make.height.width.equalTo(12)
            make.bottom.equalTo(bubbleBackgroundView.snp.bottom).offset(-8)
        }
    }


    
    func configure(message: String, time: String, checkmark: UIImage, isIncoming: Bool) {
        self.isIncoming = isIncoming
        messageLabel.text = message
        timeLabel.text = time
        checkmarkImageView.image = checkmark
        
        bubbleBackgroundView.backgroundColor = isIncoming ? UIColor.white : UIColor(hex: "#2B373E")
        messageLabel.textColor = isIncoming ? UIColor.black : UIColor.white
    }
}
