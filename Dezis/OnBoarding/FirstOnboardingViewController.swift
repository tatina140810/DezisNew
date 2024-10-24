import UIKit
import SnapKit

class FirstOnboardingViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    
    private var exterminatorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image12)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var cockroachImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image15)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать! Готовы к чистым переменам?"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var nextButton = ButtonSettings().buttonMaker(title: "Продолжить", target: self, action: #selector(nextButtonTapped))
    private lazy var skipButton = ButtonSettings().buttonMaker(title: "Пропустить", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(skipButtonTapped))

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(hex: "#1B2228")
       navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    
    private func setupUI() {
        view.addSubview(exterminatorImage)
        exterminatorImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(78)
            make.centerX.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(375)
        }
        
        view.addSubview(cockroachImage)
        cockroachImage.snp.makeConstraints { make in
            make.height.equalTo(112.42)
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(422)
            make.leading.equalToSuperview().offset(16)
        }
        
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
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-28)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    @objc func skipButtonTapped(){
        let vc = ChoiceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func nextButtonTapped(){
        let vc = SecondOnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
