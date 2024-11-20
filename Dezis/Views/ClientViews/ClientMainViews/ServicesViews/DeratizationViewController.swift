import UIKit

class DeratizationViewController: UIViewController {
   
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)

        // Создаем шаблонное изображение
        let chevronImage = UIImage(resource: .shevron).withRenderingMode(.alwaysTemplate)
        
        // Изменяем цвет изображения
        let tintedChevronImage = chevronImage.withTintColor(.systemBlue)

        // Меняем размер изображения
        let resizedChevron = UIGraphicsImageRenderer(size: CGSize(width: 8, height: 14)).image { _ in
            tintedChevronImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 8, height: 14)))
        }

        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = resizedChevron
            config.imagePadding = 5
            config.baseForegroundColor = .systemBlue
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -7, bottom: 0, trailing: 0)
            backButton.configuration = config
        } else {
            backButton.setTitleColor(.systemBlue, for: .normal)
            backButton.setImage(resizedChevron, for: .normal)
            backButton.tintColor = .systemBlue
            backButton.semanticContentAttribute = .forceLeftToRight
            backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 5)
            backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -5)
        }

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return backButton
    }()

    
private var titleLable: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    label.text = "Дератизация"
    label.textColor = .white
    return label
}()
    private var deratizationImage:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "serviceImage")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
        
    }()
   
    
    private var servicesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дератизация — это комплексное решение проблем, связанных с грызунами, такими как крысы и мыши, которые могут представлять угрозу для здоровья, а также причинять ущерб имуществу и продовольствию. Мы используем комплексный подход, включающий установку ловушек, использование приманок и герметизацию точек проникновения грызунов. Наши специалисты обеспечивают безопасное и оперативное устранение проблемы, минимизируя риски для окружающей среды. "
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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

        
    }
    private func setupUI(){
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(58)
            make.height.equalTo(24)
            
        }
        
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(104)
            make.centerX.equalToSuperview()
        }
        view.addSubview(deratizationImage)
        deratizationImage.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(180)
        }
        
        view.addSubview(servicesDescriptionLabel)
        servicesDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(deratizationImage.snp.bottom).offset(18)
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

        self.dismiss(animated: true, completion: nil)
    }
@objc func backButtonTapped(){
    self.dismiss(animated: true, completion: nil)
}


}

   
  
