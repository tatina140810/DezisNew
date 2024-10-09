import UIKit

class SuccessViewController: UIViewController {

    private var successImage: UIImageView = {
           let view = UIImageView()
           view.image = UIImage(resource: .successimage)
           return view
       }()
       private var titleLabel: UILabel = {
           let view = UILabel()
           view.text = "Успешный вход"
           view.font = UIFont(name: "SFProDisplay-Bold", size: 24)
           view.textAlignment = .center
           view.textColor = .white
           view.numberOfLines = 0
           return view
       }()
       
       private var subTitleLabel: UILabel = {
           let view = UILabel()
           view.text = "Пожалуйста, подождите. Вы будете перенаправлены на домашнюю страницу."
           view.font = UIFont(name: "SFProDisplay-Bold", size: 16)
           view.textAlignment = .center
           view.textColor = .white
           view.numberOfLines = 0
           return view
       }()
       private var nextButton: UIButton = {
           let view = UIButton()
           view.setTitle("Продолжить", for: .normal)
           view.setTitleColor(.white, for: .normal)
           view.backgroundColor = UIColor(hex: "#0A84FF")
           view.layer.cornerRadius = 8
           view.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
           view.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()


       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = UIColor(hex: "#1B2228")
           setupUI()
          
           }
       
       private func setupUI(){
           
           view.addSubview(successImage)
           successImage.snp.makeConstraints { make in
               make.centerY.equalToSuperview().offset(-100)
               make.centerX.equalToSuperview()
               make.height.equalTo(104)
               make.width.equalTo(287)
           }
           view.addSubview(titleLabel)
           titleLabel.snp.makeConstraints { make in
               make.top.equalTo(successImage.snp.bottom).offset(10)
               make.centerX.equalToSuperview()
           }
           view.addSubview(subTitleLabel)
           subTitleLabel.snp.makeConstraints { make in
               make.top.equalTo(titleLabel.snp.bottom).offset(10)
               make.centerX.equalToSuperview()
               make.leading.trailing.equalToSuperview().inset(30)
           }
           view.addSubview(nextButton)
           nextButton.snp.makeConstraints{make in
               make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
               make.leading.trailing.equalToSuperview().inset(16)
               make.height.equalTo(52)
           }
       }
       @objc func nextButtonTapped() {
           let vc = ClientTabBarController()
           vc.modalPresentationStyle = .fullScreen
           present(vc, animated: true, completion: nil)
       }
   }

