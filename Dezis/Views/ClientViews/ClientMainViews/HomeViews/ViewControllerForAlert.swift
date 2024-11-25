import UIKit

class ViewControllerForAlert: UIViewController {
   
    private var alertImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    private var successMarkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .successmark)
        return view
    }()
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Заявка успешно отправлена!"
        view.font = UIFont(name: "SFProText-Regular", size: 18)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setTitle("На главную", for: .normal)
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = true
        setupUI()
        overrideUserInterfaceStyle = .light
    }
    
    private func setupUI(){
        view.addSubview(alertImage)
        alertImage.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(192)
            make.width.equalTo(314)
        }
        alertImage.addSubview(successMarkImage)
        successMarkImage.snp.makeConstraints{ make in
            make.height.width.equalTo(40)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        alertImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(successMarkImage.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(16)
            
        }
        alertImage.addSubview(homeButton)
        homeButton.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(52)
        }
    }

    @objc func homeButtonTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("SwitchToTab"), object: nil, userInfo: ["tabIndex": 0])
        
        dismiss(animated: true)
        
    }
    
    
   
}
