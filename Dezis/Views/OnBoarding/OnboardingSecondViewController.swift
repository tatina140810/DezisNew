import UIKit
import SnapKit

class OnboardingSecondViewController: UIViewController {
    
    let vc = OnboardingPageViewController()
    
    private var cockroachImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(resource: .image15)
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackground()
        setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.loadNextViewController()
        }
    }
    
    func setUpBackground() {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(resource: .ellipse3)
        backgroundImage.contentMode = .scaleAspectFill
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func setupUI() {
        view.addSubview(cockroachImage)
        
        cockroachImage.snp.makeConstraints { make in
            make.height.equalTo(112.42)
            make.width.equalTo(200)
            make.top.equalToSuperview().offset(422)
            make.leading.equalToSuperview().offset(16)
        }
        
    }
    
    
    private func loadNextViewController() {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
