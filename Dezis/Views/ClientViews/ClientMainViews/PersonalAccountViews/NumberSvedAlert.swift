import UIKit

class NumberSvedAlert: UIViewController {
   
    private var alertImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(hex: "#1B2228")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
     private var succesImage: UIImageView = {
         let view = UIImageView()
         view.image = UIImage(resource: .curledSuccessmark)
         return view
     }()
   
    private var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Изменения успешно сохранены изменения"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 20)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setupUI()
        overrideUserInterfaceStyle = .light
        navigationController?.navigationBar.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        
        }
    }
    
    private func setupUI(){
        view.addSubview(alertImage)
        alertImage.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(152)
            make.width.equalTo(330)
        }
        view.addSubview(succesImage)
        succesImage.snp.makeConstraints{make in
            make.top.equalTo(alertImage.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
       
        alertImage.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(succesImage.snp.bottom).offset(20)
            make.leading.trailing.equalTo(alertImage).inset(72)
            
        }
    }
   
}
