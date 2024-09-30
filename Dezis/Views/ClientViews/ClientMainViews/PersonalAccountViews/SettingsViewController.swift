import UIKit

class SettingsViewController: UIViewController {

    
    private var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 60
        view.tintColor = .black
        return view
    }()
    
    let cellIdentifier = "cell"
    
    let cellContent: [(title: String, button: UIView)] = [
        (title: "Темная тема", button: UISwitch()),
        (title: "Язык приложения", button: UIButton())
    ]
   
    
    private var deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить аккаунт", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
//    private var backButton: UIBarButtonItem = {
//        let view = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
//                                   style: .plain,
//                                   target: self,
//                                   action: #selector(backButtonTapped))
//        view.tintColor = .black
//        return view
//    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        tableViewSettings()
        navigationBarSettings()
       
        }
    private func navigationBarSettings(){
        navigationItem.title = "Настройки"
    }

        @objc private func backButtonTapped() {
            let vc = PersonalAccountViewController()
        
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            print("Back button tapped")
          
        }
    
    private func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupUI() {
       

       
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(250)
            
        }
        view.addSubview(deleteAccountButton)
        deleteAccountButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-90)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(130)
        }
    }
  
    @objc private func deleteAccountButtonTapped() {
        print("Delete Account button tapped")
        // Add your logic here
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let content = cellContent[indexPath.row]
        cell.textLabel?.text = content.title
        
        // Add the button (like UISwitch or UIButton) to the accessory view
        cell.accessoryView = content.button
        
        return cell
    }
}
