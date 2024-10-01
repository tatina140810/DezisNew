
import UIKit

class SecondStackView: UIView {
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
    private var horizintalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = 12
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(hex: "#1599EE")
        view.distribution = .fillEqually
        return view
    }()
    
    private var dataView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#86b7df")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let lustDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата: "
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.text = "22.10.2023"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private var timeView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#86b7df")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let lustTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "14:30"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private var serviceView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#86b7df")
        view.layer.cornerRadius = 10
        return view
    }()
    private let lustServiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Услуга:"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинфекция"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupShadow()
        addGradientToStackView()
    }
    
    private func setupUI(){
        stackView.addArrangedSubview(horizintalStackView)
        horizintalStackView.addArrangedSubview(dataView)
        horizintalStackView.addArrangedSubview(timeView)
        dataView.addSubview(lustDataLabel)
        dataView.addSubview(dataLabel)
        lustDataLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-30)
        
        }
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(lustDataLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-30)
         
        }
        
        timeView.addSubview(lustTimeLabel)
        timeView.addSubview(timeLabel)
        lustTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-30)
          
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(lustTimeLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-30)
         
        }
        
        stackView.addArrangedSubview(serviceView)
        serviceView.addSubview(lustServiceLabel)
        serviceView.addSubview(serviceLabel)
        lustServiceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-30)
           
        }
        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(lustServiceLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        
        
        addSubview(stackView)
        stackView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    private func addGradientToStackView() {
        gradientLayer.frame = stackView.bounds
        stackView.layer.insertSublayer(gradientLayer, at: 0)
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
