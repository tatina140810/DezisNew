import UIKit

class SecondOnboardingViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы знаем, как эффективно избавиться от вредителей и бактерий. Мы-ваш щит от грязи!"
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
    private var nextButton = ButtonSettings().buttonMaker(title: "Продолжить", target: self, action: #selector(nextButtonTapped))
    private var skipButton = ButtonSettings().buttonMaker(title: "Пропустить", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(skipButtonTapped))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        finishOnboarding()
    }
    
    private func setupUI(){
        view.addSubview(ellipsImage)
        ellipsImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(236)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            
        }
        view.addSubview(exterminatorImage)
        exterminatorImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.height.equalTo(322)
            make.width.equalTo(360)
            
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
    @objc func skipButtonTapped(){
        let vc = ChoiceViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @objc func nextButtonTapped(){
        let vc = ChoiceViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @objc func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        
        let mainViewController = ChoiceViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        present(mainViewController, animated: true, completion: nil)
    }
    
}
