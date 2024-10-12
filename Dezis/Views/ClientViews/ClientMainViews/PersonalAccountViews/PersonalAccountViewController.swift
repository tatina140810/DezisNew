import UIKit
import SnapKit

class PersonalAccountViewController: UIViewController {
    
    let imagePicker = ImagePicker()
    
    private var userImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .profile1), for: .normal)
        button.addTarget(self, action: #selector(userImageTapped), for: .touchUpInside)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ф.И.О."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private var historyButton: UIButton = {
        let button = UIButton()
        button.setTitle("История заказов", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        button.tintColor = . white
        button.backgroundColor = UIColor(hex: "#2B373E")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        
    }
    
    
    
    private func setupUI() {
        view.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
            make.height.equalTo(152)
            make.width.equalTo(130)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-90)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
            
        }
    }
    @objc func historyButtonTapped() {
        let vc = ClientHistoryViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
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
    
    private func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.showImagePicker(in: self) { [weak self] image in
            
            self?.userImage.setImage(image, for: .normal)
            self?.userImage.setTitle("Image Selected", for: .normal)
        }
    }
}
