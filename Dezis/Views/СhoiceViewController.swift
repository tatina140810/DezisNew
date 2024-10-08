import UIKit

class ChoiceViewController: UIViewController {
    
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .logo)
        return image
    }()
    private var consumerButton = ButtonSettings().buttonMaker(title: "Пользователь", target: self, action: #selector(consumerButtonTapped))
    private var adminButton = ButtonSettings().buttonMaker(title:"Администратор", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(adminButtonTapped))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        
    }
    
    private func setupUI(){
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(203)
            make.width.equalTo(190)
        }
        
        
        view.addSubview(adminButton)
        adminButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            
        }
        
        view.addSubview(consumerButton)
        consumerButton.snp.makeConstraints { make in
            make.bottom.equalTo(adminButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    @objc func consumerButtonTapped() {
        let vc = ClientChoiceViewController()
       vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @objc func adminButtonTapped() {
        let vc = AdminTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    

}
