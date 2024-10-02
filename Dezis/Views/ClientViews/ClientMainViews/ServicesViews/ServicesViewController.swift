import UIKit
import SnapKit


struct Service {
    let image: UIImage
    let title: String
}

class ServicesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
  
    let services = [
        Service(image: UIImage(resource: .serImage1), title: "Дератизация"),
        Service(image: UIImage(resource: .serimage2), title: "Дезинсекция"),
        Service(image: UIImage(resource: .serimage3), title: "Дезинфекция")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Услуги"
        
        setupCollectionView()
    }
    func navigateToUserViewController(at indexPath: IndexPath) {
        let service = services[indexPath.row]
        if indexPath.row == 0 {
          
            let deratizationVC = DeratizationViewController()
            deratizationVC.title = service.title
            navigationController?.pushViewController(deratizationVC, animated: true)
        } else if indexPath.row == 1 {
            let dezinsectionVC = DezinsectionViewController()
            dezinsectionVC.title = service.title
            navigationController?.pushViewController(dezinsectionVC, animated: true)
        } else if indexPath.row == 2 {
            let dezinfectionVC = DezinfectionViewController()
            dezinfectionVC.title = service.title
            navigationController?.pushViewController(dezinfectionVC, animated: true)
        }
    }

    
    private func setupCollectionView() {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 290, height: 320)
        layout.minimumLineSpacing = 10
        
  
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

 
        collectionView.register(CustomCellForServicesCollectionView.self, forCellWithReuseIdentifier: "ServiceCell")
       
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(320)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}


extension ServicesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath) as! CustomCellForServicesCollectionView
        let service = services[indexPath.item]
        cell.configure(with: service)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            navigateToUserViewController(at: indexPath)
        }
}

   
