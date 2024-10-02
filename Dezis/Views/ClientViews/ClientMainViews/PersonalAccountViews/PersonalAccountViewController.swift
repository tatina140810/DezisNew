import UIKit
import SnapKit

class PersonalAccountViewController: UIViewController {
   
    let imagePicker = ImagePicker()
    
    private var userImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .vector), for: .normal)
        button.addTarget(self, action: #selector(userImageTapped), for: .touchUpInside)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Aleksey Ivanovich"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 60
        view.tintColor = .black
        return view
    }()
    
    let cellIdentifier = "cell"
    
    enum CellType {
            case userInfo, aboutUs, settings
        }
    
    let cellContent: [(image: UIImage?, title: String, type: CellType)] = [
           (image: UIImage(systemName: "person.fill"), title: "Профиль", type: .userInfo),
           (image: UIImage(systemName: "shield"), title: "О нас", type: .aboutUs),
           (image: UIImage(systemName: "gearshape.fill"), title: "Настройки", type: .settings)
       ]
    private var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .exit), for: .normal)
        button.setTitle(" Выйти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(hex: "#BABBBD"), for: .normal)
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        tableViewSettings()
    }
    
    private func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func navigateToViewController(at indexPath: IndexPath) {
            let content = cellContent[indexPath.row]
            let viewController: UIViewController

            switch content.type {
            case .userInfo:
                viewController = UserInfoViewController()
            case .aboutUs:
                viewController = AboutUsViewController()
            case .settings:
                viewController = SettingsViewController()
            }

            navigationController?.pushViewController(viewController, animated: true)
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
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(250)
        }
        view.addSubview(exitButton)
           exitButton.snp.makeConstraints { make in
               make.bottom.equalToSuperview().offset(-90)
               make.centerX.equalToSuperview()
               make.height.equalTo(44)
               make.width.equalTo(100)
           }
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

    @objc private func userInfoButtonTapped() {
        let vc = UserInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("User info Button Tapped")
    }
    
    @objc private func aboutUsButtonTapped() {
        let vc = AboutUsViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("About Us Button Tapped")
    }
    
    @objc private func settingsButtonTapped() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
        print("Settings Button Tapped")
    }
    @objc private func exitButtonTapped() {
        print("Exit button tapped")
        // Add your exit logic here
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PersonalAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            navigateToViewController(at: indexPath)
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let content = cellContent[indexPath.row]
        cell.imageView?.image = content.image
        cell.textLabel?.text = content.title
        
        return cell
    }
}
