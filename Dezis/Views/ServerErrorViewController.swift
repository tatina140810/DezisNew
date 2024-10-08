
import UIKit
import SnapKit

class ServerErrorViewController: UIViewController {
    
    private let dezisImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dezisGroup")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let techProbLabel: UILabel = {
        let label = UILabel()
        label.text = "Технические неполадки"
        label.textColor = .white
        if let sfProDisplayFont = UIFont(name: "SF Pro Display", size: 24) {
            label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: sfProDisplayFont)
        } else {
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Извините за неудобства, возникли технические неполадки в нашем приложении. Мы работаем над исправлением проблемы. Пожалуйста, попробуйте обновить приложение. Спасибо за ваше понимание!"
        label.textColor = .white
        if let sfProDisplayFont = UIFont(name: "SF Pro Display", size: 16) {
            label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: sfProDisplayFont)
        } else {
            label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let refreshBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Обновить", for: .normal)
        if let sfProDisplayFont = UIFont(name: "SF Pro Display-Bold", size: 16) {
            btn.titleLabel?.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: sfProDisplayFont)
        } else {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        btn.tintColor = .white
        btn.backgroundColor = .init(hex: "0A84FF")
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(refreshBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(hex: "#14191E")
        setupConstraints()
    }
    
    @objc private func refreshBtnTapped() {
        
    }
    
    private func setupConstraints(){
        view.addSubview(dezisImage)
        dezisImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(62)
            make.centerX.equalToSuperview()
            make.height.equalTo(203)
            make.width.equalTo(190)
        }
        
        view.addSubview(techProbLabel)
        techProbLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dezisImage.snp.bottom).offset(20)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(techProbLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(refreshBtn)
        refreshBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.height.equalTo(52)
            make.width.equalTo(335)
        }
    }
}

