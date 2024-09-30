import UIKit

class FirstStackView: UIView {
    
    let gradientLayer = GradientLayer()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 8
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.distribution = .fillEqually
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша первая обработка:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "• Дата: 22.10.2023"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "• Время: 14:30"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.text = "• Услуга: Дезинфекция"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupShadow()
        addGradientToStackView()
        
    }
    private func addGradientToStackView() {
        gradientLayer.frame = stackView.bounds
        stackView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupUI(){
        stackView.addArrangedSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(stackView).offset(14)
            make.leading.equalTo(stackView).offset(14)
        }
        stackView.addArrangedSubview(dateLabel)
        dateLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(stackView).offset(25)
        }
        stackView.addArrangedSubview(timeLabel)
        timeLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.leading.equalTo(stackView).offset(25)
        }
        stackView.addArrangedSubview(serviceLabel)
        serviceLabel.snp.makeConstraints{ make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.leading.equalTo(stackView).offset(25)
          
        }
        
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
