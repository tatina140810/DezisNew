import UIKit

class ForthOnboardingViewController: UIPageViewController {
    
    
    private var vectorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .vector21)
        return image
        
    }()
    private var orderImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image21)
        return image
        
    }()
   
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Поддержка всегда рядом! Общайтесь с менеджером через встроенный чат."
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private lazy var nextButton = ButtonSettings().buttonMaker(title: "Продолжить", target: self, action: #selector(nextButtonTapped))
    private lazy var skipButton = ButtonSettings().buttonMaker(title: "Пропустить", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(skipButtonTapped))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI(){
        
        view.addSubview(vectorImage)
        vectorImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(66.4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(25.16)
            make.height.equalTo(537)
            
        }
        view.addSubview(orderImage)
        orderImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(94)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(333)
            
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(orderImage.snp.bottom).offset(21.67)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-40)
        }
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-51)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints{make in
            make.bottom.equalTo(skipButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
    
@objc func skipButtonTapped(){
    let vc = ChoiceViewController()
    navigationController?.pushViewController(vc, animated: true)
    
}
    @objc func nextButtonTapped(){
        let vc = FifthOnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

