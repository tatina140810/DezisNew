import UIKit
import SnapKit


protocol PersonalAccountView: AnyObject {
    func showUserData(user: UserProfile)
    func showError(_ error: String)
}

class PersonalAccountViewController: UIViewController, PersonalAccountView {
    var email: String?
    
    let imagePicker = ImagePicker()
    var presenter: IPersonalAccountPresenter?
    var newNumber: String = ""
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        return image
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(userImageTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ф.И.О."
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let nameTextField: UITextField = {
        let field = UITextField()
        field.text = " "
        field.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        field.textColor = .white
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.layer.cornerRadius = 8
        field.clipsToBounds = true
        field.isUserInteractionEnabled = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = .white
        return label
    }()
    
    private let emailTextField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        field.textColor = .white
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.layer.cornerRadius = 8
        field.clipsToBounds = true
        field.isUserInteractionEnabled = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = .white
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        field.textColor = .white
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.layer.cornerRadius = 8
        field.isSecureTextEntry = true
        field.clipsToBounds = true
        field.isUserInteractionEnabled = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = .white
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let field = UITextField()
        field.text = ""
        field.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        field.textColor = .white
        field.backgroundColor = UIColor(hex: "#2B373E")
        field.layer.cornerRadius = 8
        field.clipsToBounds = true

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        field.isUserInteractionEnabled = true
        return field
    }()
    private lazy var historyButton: UIButton = {
        let button = UIButton()
        button.setTitle("История заказов", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#2B373E")
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        let arrowImageView = UIImageView(image: UIImage(named: "arrow-right"))
        arrowImageView.tintColor = UIColor(hex: "#0A84FF")
        button.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(button.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        button.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = UIColor(hex: "#2B373E")
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        presenter = PersonalAccountPresenter(view: self, userService: UserNetworkService())
               presenter?.fetchUserData()
        editButtonSetup()
    }
    func editButtonSetup(){
        let editButton = UIButton(type: .custom)
            editButton.setImage(UIImage(named: "edit2"), for: .normal)
            editButton.tintColor = UIColor(hex: "#0A84FF")
            editButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            editButton.addTarget(self, action: #selector(enableEditing), for: .touchUpInside)

           
            let rightPaddingView = UIView(frame: CGRect(x: -15, y: 0, width: 24, height: 24))
            rightPaddingView.addSubview(editButton)
            editButton.center = rightPaddingView.center

            phoneTextField.rightView = rightPaddingView
            phoneTextField.rightViewMode = .always
    }
    
    func showUserData(user: UserProfile) {
        print("User data loaded: \(user)")
        DispatchQueue.main.async {
                self.nameTextField.text = user.username
                self.emailTextField.text = user.email
                self.phoneTextField.text = user.number
                self.passwordTextField.text = user.password
            }
        }
       
    func showError(_ error: String) {
           
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    
    private func setupUI() {
        view.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(71)
            make.centerX.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(120)
        }

        view.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.bottom.equalTo(userImage.snp.bottom)
            make.trailing.equalTo(userImage.snp.trailing)
            make.height.width.equalTo(30)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(historyButton.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
    }
    
    @objc func historyButtonTapped() {
        let vc = ClientHistoryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func userImageTapped() {
        let alertController = UIAlertController(title: "Выберите фото профиля", message: "Выберите фото из галереи или сделайте новое фото.", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { [weak self] _ in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                let alert = UIAlertController(title: "Ошибка", message: "Камера не доступна.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
                return
            }
            self?.showImagePicker(sourceType: .camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Галерея", style: .default) { [weak self] _ in
            self?.showImagePicker(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc private func enableEditing() {
        saveUpdatedNumber()
        print("button tupped")
        
    }

    @objc private func saveUpdatedNumber() {
       
        guard let newNumber = phoneTextField.text, !newNumber.isEmpty else {
            print("Ошибка: номер телефона не может быть пустым")
            return
        }
        
        presenter?.updateUserNumber(newNumber: newNumber)
        let vc = NumberSvedAlert()
        navigationController?.present(vc, animated: true)
    }

    
    private func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.showImagePicker(in: self) { [weak self] image in
            self?.userImage.image = image
        }
    }
    @objc func exitButtonTapped() {
        
        let vc = ExitAlertView()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve   
        
        present(vc, animated: true, completion: nil)
    }
}

