import UIKit

class ClientErrorViewController: UIViewController {
    
        private var tryLabel: UILabel = {
            let label = UILabel()
            label.text = "Попробуйте позже"
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            return label
        }()
        
        private var helpLabel: UILabel = {
            let label = UILabel()
            label.text = "Если вам нужна помощь, позвоните по указанному номеру:"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .black
            label.numberOfLines = 0
            return label
        }()
        private var numberLabel: UILabel = {
            let label = UILabel()
            label.text = "+9966658349"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .black
            return label
        }()
        private var insectImage: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(resource: .insect)
            return view
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupUI()
        }
        private func setupUI(){
            view.addSubview(tryLabel)
            tryLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(180)
                make.centerX.equalToSuperview()
            }
            view.addSubview(helpLabel)
            helpLabel.snp.makeConstraints { make in
                make.top.equalTo(tryLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.leading.equalTo(40)
                make.trailing.equalTo(-40)
            }
            view.addSubview(numberLabel)
            numberLabel.snp.makeConstraints { make in
                make.top.equalTo(helpLabel.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
            }
            view.addSubview(insectImage)
            insectImage.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalToSuperview()
                make.height.equalTo(233)
                make.width.equalTo(222)
            }
        }
        

    }
