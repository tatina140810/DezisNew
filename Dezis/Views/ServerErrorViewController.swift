
import UIKit

class ServerErrorViewController: UIViewController {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы столкнулись с внутренней серверной ошибкой. Приносим искренние извинения за доставленные неудобства."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private var insectImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .insect)
        return view
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    private func setupUI(){
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.centerX.equalToSuperview()
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
        }
        
        view.addSubview(insectImage)
        insectImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(233)
            make.width.equalTo(222)
        }
        view.addSubview(helpLabel)
        helpLabel.snp.makeConstraints { make in
            make.top.equalTo(insectImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
        }
        view.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(helpLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    

}
