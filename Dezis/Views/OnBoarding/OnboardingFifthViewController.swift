import UIKit

class OnboardingFifthViewController: UIPageViewController {
    
    private var ellipsImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .ellipse71)
        return image
        
    }()
    private var sprayImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image16)
        return image
        
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы указываете проблему-мы создаем чистоту быстро и профессионально."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }
    
    private func setupUI(){
        view.addSubview(ellipsImage)
        ellipsImage.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        view.addSubview(sprayImage)
        sprayImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(142)
            make.width.equalTo(360)
            make.height.equalTo(244.8)
            make.leading.trailing.equalToSuperview()
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(sprayImage.snp.bottom).offset(100)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            
            
        }
        
    }
    
}
