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
        label.font = UIFont(name: "SFProText-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private var firstStackView = FirstStackView()
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Услуги"
        label.font = UIFont(name: "SFProText-Bold", size: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private var dezinsectionView = DezinsectionView()
   
    private lazy var dezinsectionDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        button.setImage(UIImage(resource: .arrow), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        let screenWidth = UIScreen.main.bounds.width

        let imageLeftInset = screenWidth * 0.53

        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeftInset, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft

        return button
    }()
    
   private var dezinfectionView = DezinfectionView()
    
    private lazy var dezinfectionDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        button.setImage(UIImage(resource: .arrow), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        let screenWidth = UIScreen.main.bounds.width

        let imageLeftInset = screenWidth * 0.53

        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeftInset, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
    
        return button
    }()
    
    private var deratizationView = DeratizationView()
    
    private lazy var deratizationDetailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        button.setImage(UIImage(resource: .arrow), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        
        let screenWidth = UIScreen.main.bounds.width

        let imageLeftInset = screenWidth * 0.53

        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeftInset, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.semanticContentAttribute = .forceRightToLeft
        
        return button
    }()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupAddTarget()
        setupUI()
        navigationController?.setNavigationBarHidden(true, animated: true)
       navigationItem.hidesBackButton = true
   
    }
  
    private func setupAddTarget() {
        deratizationDetailsButton.addTarget(self, action: #selector(deratizationButtonTapped), for: .touchUpInside)
        dezinfectionDetailsButton.addTarget(self, action: #selector(dezinfectionButtonTapped), for: .touchUpInside)
        dezinsectionDetailsButton.addTarget(self, action: #selector(dezinsectionButtonTapped), for: .touchUpInside)
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
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @objc func dezinfectionButtonTapped(){
  
        let vc = DezinfectionViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)   
    }
    @objc func deratizationButtonTapped(){
       
        let vc = DeratizationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)  
    }
}

