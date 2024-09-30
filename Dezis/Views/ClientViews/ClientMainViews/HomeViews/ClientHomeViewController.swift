import UIKit
import SnapKit

class ClientHomeViewController: UIViewController {
   
    private lazy var scrollView: UIScrollView = {
            let view = UIScrollView()
            return view
        }()
        private lazy var contentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
    
    private var stackView = FirstStackView()
    
    private let lustOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваша последняя обработка:"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private var secondStackView = SecondStackView()
    
   
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Информация о записи и услугах"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private var thirdStackView = ThirdStackView()
    
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Оставьте заявку для защиты бактерий и вредителей!"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Оставить заявку", for: .normal)
        button.backgroundColor = UIColor(hex: "#0688C1")
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        
        return button
        
    }()
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItems()
        setupUI()
        setupOrderButton()
    }
   
    func setupNavigationItems(){
        let rightButton = UIBarButtonItem(image: UIImage(resource: .messengerLogo), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        let leftButton = UIBarButtonItem(image: UIImage(resource: .image8), style: .plain, target: self, action: #selector(leftButtonTapped))
        navigationItem.leftBarButtonItem = leftButton
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

        // StackView 1
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(5)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(173)
        }

        contentView.addSubview(lustOrderLabel)
        lustOrderLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
        }

        // StackView 2
        contentView.addSubview(secondStackView)
        secondStackView.snp.makeConstraints { make in
            make.top.equalTo(lustOrderLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(173)
        }

        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(secondStackView.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
        }

        // StackView 3
        contentView.addSubview(thirdStackView)
        thirdStackView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(370)
        }

        contentView.addSubview(orderLabel)
        orderLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdStackView.snp.bottom).offset(20)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20) 
            // Это важно для корректной работы scrollView
        }
    }

    private func setupOrderButton() {
        view.addSubview(orderButton)
        
        orderButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(48)
        }
    }
    
    @objc func leftButtonTapped() {
        print("Left button tapped")
    }

    @objc func rightButtonTapped() {
        let vc = ClientChatViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("Right button tapped")
    }
    @objc func orderButtonTapped(){
        let vc = SuccessAlertForOrderButtonViewController()
    
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

