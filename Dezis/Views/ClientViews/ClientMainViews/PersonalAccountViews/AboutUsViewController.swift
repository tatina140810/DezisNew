import UIKit
import SnapKit

class AboutUsViewController: UIViewController {
    
    private var settingsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "О Нас"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private var cardsView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(hex: "#0688C1")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private var flatsInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "720 квартир"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private var flatsInfoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "обработано в Кыргызстане"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var secondCardsView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(hex: "#0688C1")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private var yearsInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "10 лет"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private var yearsInfoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "на страже чистоты"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var thirdCardsView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(hex: "#0688C1")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private var thirdCardsLabel: UILabel = {
        let label = UILabel()
        label.text = "1 400 000 м²"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private var thirdCardsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "ежемесячно обрабатываем"
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Адрес:"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var adressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Кыргызская Республика, г.Бишкек ул. Айни 215"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private var workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Режим работы:"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var workTimeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Круглосуточно 24/7 по записи заранее"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон:"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var phoneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "+996 999 033 330"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    private var stackView: UIStackView  = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 40
        view.alignment = .center
        view.distribution = .fillEqually
        
        return view
    }()
  
    private var telegramButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .telegramIcon), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(telegramButtonTapped), for: .touchUpInside)
        return button
    }()
    private var instagramButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .instagramIcon), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(instagramButtonButtonTapped), for: .touchUpInside)
        return button
    }()
    private var whatsappButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .whatsappIcon), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(whatsappButtonButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(settingsTitleLabel)
        settingsTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(107)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(cardsView)
        cardsView.snp.makeConstraints { make in
            make.top.equalTo(settingsTitleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(64)
        }
        
        cardsView.addSubview(flatsInfoLabel)
        flatsInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        cardsView.addSubview(flatsInfoDescriptionLabel)
        flatsInfoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(flatsInfoLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        view.addSubview(secondCardsView)
        secondCardsView.snp.makeConstraints { make in
            make.top.equalTo(cardsView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(64)
        }
        
        secondCardsView.addSubview(yearsInfoLabel)
        yearsInfoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        secondCardsView.addSubview(yearsInfoDescriptionLabel)
        yearsInfoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(yearsInfoLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        view.addSubview(thirdCardsView)
        thirdCardsView.snp.makeConstraints { make in
            make.top.equalTo(secondCardsView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(64)
        }
        
        thirdCardsView.addSubview(thirdCardsLabel)
        thirdCardsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
        
        thirdCardsView.addSubview(thirdCardsDescriptionLabel)
        thirdCardsDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdCardsLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        view.addSubview(adressLabel)
        adressLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdCardsView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(adressDescriptionLabel)
        adressDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            
        }
        view.addSubview(workTimeLabel)
        workTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(adressDescriptionLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(workTimeDescriptionLabel)
        workTimeDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(workTimeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            
        }
        view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(workTimeDescriptionLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(phoneDescriptionLabel)
        phoneDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            
        }
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(phoneDescriptionLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
            
        }
        stackView.addArrangedSubview(telegramButton)
        stackView.addArrangedSubview(instagramButton)
        stackView.addArrangedSubview(whatsappButton)
    }
    @objc func telegramButtonTapped(){
        print("telegram buton tapped")
    }
    @objc func instagramButtonButtonTapped(){
        print("instagram buton tapped")
    }
    @objc func whatsappButtonButtonTapped(){
        print("whatsapp buton tapped")
    }
    
}

