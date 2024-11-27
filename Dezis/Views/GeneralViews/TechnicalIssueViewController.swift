
import UIKit

class TechnicalIssueViewController: UIViewController {
  
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .logo)
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Технические неполадки"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Извините за неудобства, возникли технические неполадки в нашем приложении. Мы работаем над исправлением проблемы. Пожалуйста, попробуйте обновить приложение. Спасибо за Ваше понимание!"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return label
    }()
   
    
    private lazy var updateButton = ButtonSettings().buttonMaker(title:"Обновить", backgroundColor: UIColor(hex: "#0A84FF"), target: self, action: #selector(updateButtonTapped))
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        }

    private func setupUI(){
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(62)
            make.centerX.equalToSuperview()
            make.height.equalTo(203)
            make.width.equalTo(190)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            
        }
        
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        
        view.addSubview(updateButton)
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
            
        }
    }
        
  
    @objc func updateButtonTapped() {
        let vc = ClientChoiceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
