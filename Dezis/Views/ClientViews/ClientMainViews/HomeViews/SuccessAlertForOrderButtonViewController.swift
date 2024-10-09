
import UIKit

class SuccessAlertForOrderButtonViewController: UIViewController {
  
   
    private var alertImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    private var successMarkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .successmark)
        return view
    }()
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Заявка успешно отправлена. Наш менеджер свяжется с вами в ближайшее время!"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [weak self] in
            self?.loadNextViewController()
        }
    }
    private func setupUI(){
        view.addSubview(alertImage)
        alertImage.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(173)
            make.width.equalTo(373)
        }
        alertImage.addSubview(successMarkImage)
        successMarkImage.snp.makeConstraints{ make in
            make.height.width.equalTo(50)
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        alertImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(successMarkImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(56)
            make.trailing.equalToSuperview().offset(-56)
        }
    }
       private func loadNextViewController() {
       
               dismiss(animated: true, completion: nil)
            }
}
