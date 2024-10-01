import UIKit

class CustomCellForServicesCollectionView: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    private func setupUI(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(100)
            make.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with service: Service) {
        imageView.image = service.image
        titleLabel.text = service.title
    }
}
