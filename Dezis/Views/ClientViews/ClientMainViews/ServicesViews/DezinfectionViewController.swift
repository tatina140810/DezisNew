
import UIKit

class DezinfectionViewController: UIViewController {
    
    private var dezincectionImage:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .rectangle455)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
        
    }()
    private var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Дезинфекция"
        label.textColor = .white
        return label
    }()
    private var servicesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинфекция — это обработка помещений, направленная на уничтожение опасных вирусов, бактерий и грибков, а также других микроорганизмов, способных вызвать серьёзные заболевания. Процедура также помогает избавиться от неприятных запахов, плесени и высолов. Мы предлагаем услуги дезинфекции жилых и коммерческих объектов, используя современные и безопасные дезинфицирующие средства. "
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
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
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(hex: "#1B2228")
        
        
    }
    private func setupUI(){
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        view.addSubview(dezincectionImage)
        dezincectionImage.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(300)
        }
        
        view.addSubview(servicesDescriptionLabel)
        servicesDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dezincectionImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
        }
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(48)
        }
    }
    @objc func orderButtonTapped(){
        let vc = ViewControllerForAlert()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
