import UIKit
class FirstStackView: UIView {
        
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 8
        view.backgroundColor = UIColor(hex: "#1B2228")
        view.distribution = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 14, right: 14)
        return view
    }()
    
    private var firstStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .center
        view.distribution = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return view
    }()
    
    private var secondStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .center
        view.distribution = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return view
    }()
    
    private var thirdStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .center
        view.distribution = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return view
    }()
    
    private var firstImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .first)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var secondImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .second)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var thirdImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .third)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Запись ведется не менее чем за один день до даты услуги."
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let secondTextLabel: UILabel = {
        let label = UILabel()
        label.text = "После бронирования услуги, наш менеджер свяжется с вами для подтверждения заявки и уточнения деталей."
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let thirdTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Изменение или отмена бронирования возможны не позднее, чем за 24 часа до назначенного времени."
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        // Первый горизонтальный стек
        firstStackView.addArrangedSubview(firstImage)
        firstImage.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        firstStackView.addArrangedSubview(firstTextLabel)
        
        stackView.addArrangedSubview(firstStackView)
        
        // Второй горизонтальный стек
        secondStackView.addArrangedSubview(secondImage)
        secondImage.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        secondStackView.addArrangedSubview(secondTextLabel)
        
        stackView.addArrangedSubview(secondStackView)
        
        // Третий горизонтальный стек
        thirdStackView.addArrangedSubview(thirdImage)
        thirdImage.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        thirdStackView.addArrangedSubview(thirdTextLabel)
        
        stackView.addArrangedSubview(thirdStackView)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
