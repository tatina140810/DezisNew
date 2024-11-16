import UIKit

class DezinfectionView: UIView {
   
    private var backgroundView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(hex: "#2B373E")
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private let firstTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинфекция"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 22)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private let dezinsectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Основные проблемы с паразитами — это клопы, тараканы и блохи, а также летающие насекомые, которые кусают и нарушают комфорт человека. "
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    private func setupUI(){
        
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
        backgroundView.addSubview(firstTextLabel)
        firstTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(20)
        }
        backgroundView.addSubview(dezinsectionDescriptionLabel)
        dezinsectionDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTextLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
