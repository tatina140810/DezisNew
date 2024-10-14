import UIKit
import Reachability

class ChoiceViewController: UIViewController {
    let reachability = try! Reachability()
    
    
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .logo)
        return image
    }()
    private lazy var consumerButton = ButtonSettings().buttonMaker(title: "Пользователь", target: self, action: #selector(consumerButtonTapped))
    private lazy var adminButton = ButtonSettings().buttonMaker(title:"Администратор", backgroundColor: UIColor(hex: "#1B2228"), target: self, action: #selector(adminButtonTapped))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        setupReachability()
        
       
    }
    func setupReachability(){
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async{
                self.showNoInternetAlert(message: "Нет интернет-соединения")
            }
        }
            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier!")
            }
    }
    func showNoInternetAlert(message: String) {
                let alertView = UIView()
                alertView.backgroundColor = UIColor(hex: "#0A84FF")
                let alertLabel = UILabel()
                alertLabel.text = message
                alertLabel.textColor = .white
                alertLabel.textAlignment = .center
                alertLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
       
                alertView.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(alertView).offset(20)
            make.centerX.equalTo(alertView)
        }
          
    
        
                view.addSubview(alertView)
    
                alertView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: 107)
                
   
                UIView.animate(withDuration: 0.5, animations: {
                    alertView.frame.origin.y = 50
                }) { _ in
             
                    UIView.animate(withDuration: 0.5, delay: 3, options: [], animations: {
                        alertView.frame.origin.y = -100
                    }) { _ in
                        alertView.removeFromSuperview()
                    }
                }
            }
            
            @objc func showAlertButtonTapped() {
                showNoInternetAlert(message: "Нет соединения с интернетом")
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
        let vc = AdminLoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    

}
