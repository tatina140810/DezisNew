import UIKit

class ForthOnboardingViewController: UIPageViewController {
    
    
    private var vectorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .wave)
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
    private var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пропустить", for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        finishOnboarding() 
    }
    private func setupUI(){
        
        view.addSubview(vectorImage)
        vectorImage.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
        view.addSubview(orderImage)
        orderImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(333)
            
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(orderImage.snp.bottom).offset(200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints{make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(130)}
    }
    
    
    @objc func finishOnboarding() {
            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
            
            let mainViewController = ClientTabBarController() 
            mainViewController.modalPresentationStyle = .fullScreen
            present(mainViewController, animated: true, completion: nil)
        }
@objc func skipButtonTapped(){
    let vc = ClientTabBarController()
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
}
    
}

