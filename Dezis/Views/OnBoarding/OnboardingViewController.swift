import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    let vc = OnboardingSecondViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBackground()
        
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
    
    
    private func loadNextViewController() {
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
