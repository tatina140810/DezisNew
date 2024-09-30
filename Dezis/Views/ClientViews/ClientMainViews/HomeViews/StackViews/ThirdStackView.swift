import UIKit

class ThirdStackView: UIView {
    let gradientLayer = GradientLayer()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 8
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hex: "#1599EE")
        view.distribution = .fillEqually
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return view
    }()
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.text = "1. Запись ведется не менее чем за один день до даты услуги."
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let secondtextLabel: UILabel = {
        let label = UILabel()
        label.text = "2. После бронирования услуги, наш менеджер свяжется с вами для подтверждения заявки и уточнения деталей."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private let thirdTextLabel: UILabel = {
        let label = UILabel()
        label.text = "3. Изменение или отмена бронирования возможны не позднее, чем за 24 часа до назначенного времени."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupShadow()
        addGradientToStackView()
    }
    
    private func setupUI(){
        stackView.addArrangedSubview(firstTextLabel)
      
        stackView.addArrangedSubview(secondtextLabel)

        stackView.addArrangedSubview(thirdTextLabel)
       
        addSubview(stackView)
        stackView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
              
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addGradientToStackView() {
        gradientLayer.frame = stackView.bounds
        stackView.layer.insertSublayer(gradientLayer, at: 0)
    }
             
    private func setupShadow() {
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.5
           layer.shadowOffset = CGSize(width: 0, height: 4)
           layer.shadowRadius = 8
           layer.masksToBounds = false
       }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = stackView.bounds
    }
    
}
