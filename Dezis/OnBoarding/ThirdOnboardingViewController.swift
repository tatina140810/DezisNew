import UIKit

class ThirdOnboardingViewController: UIPageViewController {
    
    private var sprayImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image16)
        return image
        
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы указываете проблему-мы создаем чистоту быстро и профессионально."
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
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
       
        view.addSubview(sprayImage)
        sprayImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(122)
            make.width.equalTo(360)
            make.height.equalTo(244.8)
            make.leading.trailing.equalToSuperview()
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(sprayImage.snp.bottom).offset(100)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
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
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func nextButtonTapped(){
        let vc = ForthOnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
