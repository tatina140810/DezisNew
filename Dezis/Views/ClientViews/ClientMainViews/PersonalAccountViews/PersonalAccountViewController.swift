import UIKit

class PersonalAccountViewController: UIViewController {
    
    private var userImage = ImageSettings().imageMaker(image: UIImage(resource: .frame5731))
    
    private var personImage = ImageSettings().imageMaker(image: UIImage(systemName: "person.fill")!)
    
    private var userInfoButton = ButtonSettings().buttonMaker(title: "Профиль", titleColor: UIColor.black, backgroundColor: UIColor.clear, target: self, action: #selector(userInfoButtonTapped))
    private var lineImage = ImageSettings().imageMaker(image: nil, backgroundColor: UIColor.black)
    
    private var shieldImage = ImageSettings().imageMaker(image: UIImage(systemName: "shield")!)
    
    private var aboutUsButton = ButtonSettings().buttonMaker(title: "О нас", titleColor: UIColor.black, backgroundColor: UIColor.clear, target: self, action: #selector(aboutUsButtonTapped))
    private var secondlineImage = ImageSettings().imageMaker(image: nil, backgroundColor: UIColor.black)
    private var gearImage = ImageSettings().imageMaker(image: UIImage(systemName: "gearshape.fill")!)
    
    private var settingsButton = ButtonSettings().buttonMaker(title: "Настройки", titleColor: UIColor.black, backgroundColor: UIColor.clear, target: self, action: #selector(settingsButtonTapped))
    private var thirdlineImage = ImageSettings().imageMaker(image: nil, backgroundColor: UIColor.black)
    private var exitLabel = LabelSettings().labelMaker(text: "Выйти")
      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    func setupUI(){
        view.addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            userImage.widthAnchor.constraint(equalToConstant: 130),
            userImage.heightAnchor.constraint(equalToConstant: 152)
        ])
        view.addSubview(personImage)
        NSLayoutConstraint.activate([
            personImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            personImage.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 30),
            personImage.heightAnchor.constraint(equalToConstant: 24),
            personImage.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        view.addSubview(userInfoButton)
        NSLayoutConstraint.activate([
            userInfoButton.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 25),
            userInfoButton.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 30),
            userInfoButton.heightAnchor.constraint(equalToConstant: 40),
            userInfoButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        view.addSubview(lineImage)
        NSLayoutConstraint.activate([
            lineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lineImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            lineImage.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 10),
            lineImage.heightAnchor.constraint(equalToConstant: 2)
        ])
        view.addSubview(shieldImage)
        NSLayoutConstraint.activate([
            shieldImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shieldImage.topAnchor.constraint(equalTo: lineImage.bottomAnchor, constant: 100),
            shieldImage.heightAnchor.constraint(equalToConstant: 24),
            shieldImage.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        view.addSubview(aboutUsButton)
        NSLayoutConstraint.activate([
            aboutUsButton.leadingAnchor.constraint(equalTo: shieldImage.trailingAnchor, constant: 25),
            aboutUsButton.topAnchor.constraint(equalTo: lineImage.bottomAnchor, constant: 30),
        ])
        
        view.addSubview(secondlineImage)
        NSLayoutConstraint.activate([
            lineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lineImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            lineImage.topAnchor.constraint(equalTo: aboutUsButton.bottomAnchor, constant: -30),
            lineImage.heightAnchor.constraint(equalToConstant: 1)
        ])
//        
        view.addSubview(gearImage)
        NSLayoutConstraint.activate([
            gearImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gearImage.topAnchor.constraint(equalTo: aboutUsButton.bottomAnchor, constant: 40),
            gearImage.heightAnchor.constraint(equalToConstant: 24),
            gearImage.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        view.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.leadingAnchor.constraint(equalTo: gearImage.trailingAnchor, constant: 25),
            settingsButton.topAnchor.constraint(equalTo: aboutUsButton.bottomAnchor, constant: 30),
        ])
        view.addSubview(exitLabel)
        NSLayoutConstraint.activate([
            exitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)])
    }
    
    @objc func userInfoButtonTapped() {
        let vc = UserInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("User info Button Tapped")
    }
    @objc func aboutUsButtonTapped() {
        let vc = AboutUsViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("About Us Button Tapped")
    }
    @objc func settingsButtonTapped() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("Settings Button Tapped")
    }
    
}
