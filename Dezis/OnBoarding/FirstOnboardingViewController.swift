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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private var nextButton = ButtonSettings().buttonMaker(title: "Продолжить", target: self, action: #selector(nextButtonTapped))
    private var skipButton = ButtonSettings().buttonMaker(title: "Пропустить", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(skipButtonTapped))

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(hex: "#1B2228")
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
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cockroachImage.snp.bottom).offset(65)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
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
        let vc = SecondOnboardingViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
