import UIKit

enum NextViewControllerType {
    case admin
    case client
}

class SuccessViewController: UIViewController {

    var nextViewControllerType: NextViewControllerType = .admin
    private var checkImage = ImageSettings().imageMaker(image: UIImage(resource: .checkCircle))
    var titleLabel = LabelSettings().labelMaker(text: "Вы успешно авторизовались!", font: UIFont.systemFont(ofSize: 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadNextViewController()
        }
    }

    private func setupUI() {
        view.addSubview(checkImage)
        NSLayoutConstraint.activate([
            checkImage.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            checkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkImage.heightAnchor.constraint(equalToConstant: 50),
            checkImage.widthAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func loadNextViewController() {
        let vc: UIViewController
        switch nextViewControllerType {
        case .admin:
            vc = AdminTabBarController() // переход на Admin
        case .client:
            vc = ClientTabBarController() // переход на Client
        }

        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
