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
        label.text = "Информация о записи и услугах"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private var firstStackView = FirstStackView()
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Услуги"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private var dezinsectionView = DezinsectionView()
   
    
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
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(370)
        }
        
        contentView.addSubview(orderLabel)
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(firstStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
//            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
            // Это важно для корректной работы scrollView
        }
        contentView.addSubview(dezinsectionView)
        dezinsectionView.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(250)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
    
    @objc func orderButtonTapped(){
        let vc = SuccessAlertForOrderButtonViewController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

