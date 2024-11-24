
import UIKit

class DezinfectionViewController: UIViewController {
    
    private var dezinfectionImage:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "serviceImage")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
        
    }()
    private var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Дезинфекция"
        label.textColor = .white
        return label
    }()
    private var servicesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинфекция — это обработка помещений, направленная на уничтожение опасных вирусов, бактерий и грибков, а также других микроорганизмов, способных вызвать серьёзные заболевания. Процедура также помогает избавиться от неприятных запахов, плесени и высолов. Мы предлагаем услуги дезинфекции жилых и коммерческих объектов, используя современные и безопасные дезинфицирующие средства. "
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Заказать услугу", for: .normal)
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(hex: "#1B2228")
        navigationItem.backButtonTitle = "Назад"
        
    }

    private func setupUI(){

        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(104)
            make.centerX.equalToSuperview()
        }
        view.addSubview(dezinfectionImage)
        dezinfectionImage.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(180)
        }
        
        view.addSubview(servicesDescriptionLabel)
        servicesDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dezinfectionImage.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(servicesDescriptionLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(52)
        }
    }
    @objc func orderButtonTapped() {
        print("button tapped")

        NotificationCenter.default.post(name: NSNotification.Name("SwitchToTab"), object: nil, userInfo: ["tabIndex": 1])

       // self.dismiss(animated: true, completion: nil)
    }

}
