import UIKit

class ExitAlertView: UIViewController {
   
    private var alertImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(hex: "#1B2228")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
   
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Вы уверенны что хотите выйти?"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    private lazy var cancellButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.backgroundColor = UIColor(hex: "#1B2228")
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.addTarget(self, action: #selector(cancellButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = UIColor(hex: "#1B2228")
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.1)
               view.isUserInteractionEnabled = true
        setupUI()
        overrideUserInterfaceStyle = .light
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI(){
        view.addSubview(alertImage)
        alertImage.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(144)
            make.width.equalTo(330)
        }
       
        alertImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(44)
            
        }
        alertImage.addSubview(cancellButton)
        cancellButton.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(44)
            make.height.equalTo(24)
            make.width.equalTo(75)
        }
        alertImage.addSubview(continueButton)
        continueButton.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.trailing.equalToSuperview().offset(-44)
            make.height.equalTo(24)
            make.width.equalTo(120)
        }
    }

    @objc func cancellButtonTapped() {
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func continueButtonTapped() {
        let vc = ChoiceViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
   
}
