import UIKit

class SecondOnboardingViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы знаем, как эффективно избавиться от вредителей и бактерий. Мы-ваш щит от грязи!"
        label.font = UIFont(name: "SFProText-Medium", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private var ellipsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .ellipse7)
        return image
        
    }()
    private var exterminatorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image17)
        return image
        
    }()
    private lazy var nextButton = ButtonSettings().buttonMaker(title: "Продолжить", target: self, action: #selector(nextButtonTapped))
    private lazy var skipButton = ButtonSettings().buttonMaker(title: "Пропустить", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(skipButtonTapped))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
    }
    
    private func setupUI(){
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-51)
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints{make in
            make.bottom.equalTo(skipButton.snp.top).offset(-16)
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        view.addSubview(ellipsImage)
        ellipsImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
        }
       
        view.addSubview(exterminatorImage)
        exterminatorImage.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-24)
            make.leading.equalToSuperview()
            make.height.equalTo(322)
            make.width.equalTo(375)
            
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(exterminatorImage.snp.top).offset(-24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            
        }
        
    }
    @objc func skipButtonTapped(){
        let vc = ChoiceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func nextButtonTapped(){
        let vc = ThirdOnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
   
    
}
