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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private var nextButton = ButtonSettings().buttonMaker(title: "Продолжить", target: self, action: #selector(nextButtonTapped))
    private var skipButton = ButtonSettings().buttonMaker(title: "Пропустить", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(skipButtonTapped))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        finishOnboarding() 
    }
    private func setupUI(){
        
        view.addSubview(vectorImage)
        vectorImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(537)
            
        }
        view.addSubview(orderImage)
        orderImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(333)
            
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(orderImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints{make in
            make.bottom.equalTo(skipButton.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    
    @objc func finishOnboarding() {
            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
            
            let mainViewController = ClientTabBarController() 
            mainViewController.modalPresentationStyle = .fullScreen
            present(mainViewController, animated: true, completion: nil)
        }
@objc func skipButtonTapped(){
    let vc = ChoiceViewController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
}
    @objc func nextButtonTapped(){
        let vc = FifthOnboardingViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}

