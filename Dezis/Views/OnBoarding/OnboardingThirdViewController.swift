import UIKit
import SnapKit

class OnboardingThirdViewController: UIViewController {
    
    private var exterminatorImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image12)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var cockroachImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image15)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать! Готовы к чистым переменам?"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackground()
        setupUI()
    }
    
    private func setUpBackground() {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(resource: .ellipse3)
        backgroundImage.contentMode = .scaleAspectFill
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        view.addSubview(exterminatorImage)
        exterminatorImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(78)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(500)
            make.width.equalTo(360)
        }
        
        view.addSubview(cockroachImage)
        cockroachImage.snp.makeConstraints { make in
            make.height.equalTo(112.42)
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(422)
            make.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cockroachImage.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
}
