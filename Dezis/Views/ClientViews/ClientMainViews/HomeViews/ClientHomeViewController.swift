import UIKit
import SnapKit

class ClientHomeViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor(hex: "#1B2228")
        return view
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#1B2228")
        return view
    }()
    
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Информация о записи"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private var firstStackView = FirstStackView()
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Услуги"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private var dezinsectionView = DezinsectionView()
   
    private var dezinsectionDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.imageView?.contentMode = .right
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(dezinsectionButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)

        return button
    }()
    
   private var dezinfectionView = DezinfectionView()
    
    private var dezinfectionDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.imageView?.contentMode = .right
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(dezinfectionButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)

        return button
    }()
    
    private var deratizationView = DeratizationView()
    
    private var deratizationDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.imageView?.contentMode = .right
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.addTarget(self, action: #selector(deratizationButtonTapped), for: .touchUpInside)
        return button
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        
        setupUI()
    }
  
    
    func setupUI(){
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(firstStackView)
        firstStackView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.height.equalTo(370)
        }
        
        contentView.addSubview(orderLabel)
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(firstStackView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        contentView.addSubview(dezinsectionView)
        dezinsectionView.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(270)
            
        }
        dezinsectionView.addSubview(dezinsectionDetailsButton)
        dezinsectionDetailsButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalTo(contentView).offset(35)
            make.trailing.equalTo(contentView).offset(-35)
            make.height.equalTo(44)
        }
            
        contentView.addSubview(dezinfectionView)
        dezinfectionView.snp.makeConstraints { make in
            make.top.equalTo(dezinsectionView.snp.bottom).offset(5)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(290)
          
        }
        dezinfectionView.addSubview(dezinfectionDetailsButton)
        dezinfectionDetailsButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalTo(contentView).offset(35)
            make.trailing.equalTo(contentView).offset(-35)
            make.height.equalTo(44)
        }
        contentView.addSubview(deratizationView)
        deratizationView.snp.makeConstraints { make in
            make.top.equalTo(dezinfectionView.snp.bottom).offset(5)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(270)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        deratizationView.addSubview(deratizationDetailsButton)
        deratizationDetailsButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.leading.equalTo(contentView).offset(35)
            make.trailing.equalTo(contentView).offset(-35)
            make.height.equalTo(44)
        }
    }
    
    @objc func dezinsectionButtonTapped(){
     
        let vc = DezinsectionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func dezinfectionButtonTapped(){
  
        let vc = DezinfectionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deratizationButtonTapped(){
       
        let vc = DeratizationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

