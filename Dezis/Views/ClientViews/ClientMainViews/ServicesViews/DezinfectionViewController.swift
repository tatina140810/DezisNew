//
//  DezinfectionViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 2/10/24.
//

import UIKit

class DezinfectionViewController: UIViewController {

    private var dezincectionImage:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .rectangle455)
        return view
        
    }()
    private var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Дезинфекция"
        return label
    }()
    private var servicesLabel: UILabel = {
        let label = UILabel()
        label.text = "• Уничтожение плесени\n• Уничтожение грибка\n• Дезинфекция от вирусов и бактерий\n• Устранение неприятных запахов\n "
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private var servicesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинфекция — это обработка помещений, направленная на уничтожение опасных вирусов, бактерий и грибков, а также других микроорганизмов, способных вызвать серьёзные заболевания. Процедура также помогает избавиться от неприятных запахов, плесени и высолов. Мы предлагаем услуги дезинфекции жилых и коммерческих объектов, используя современные и безопасные дезинфицирующие средства. "
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Заказать услугу", for: .normal)
        button.backgroundColor = UIColor(hex: "#0688C1")
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        navigationItem.title = ""

        
    }
    private func setupUI(){
        view.addSubview(dezincectionImage)
        dezincectionImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(375)
        }
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(dezincectionImage.snp.bottom).offset(10)
            make.leading.equalTo(dezincectionImage.snp.leading).offset(14)
        }
        view.addSubview(servicesLabel)
        servicesLabel.snp.makeConstraints { make in
            make.top.equalTo(dezincectionImage.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        view.addSubview(servicesDescriptionLabel)
        servicesDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(servicesLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
        }
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(48)
        }
    }
    @objc func orderButtonTapped(){
        let vc = SuccessAlertForOrderButtonViewController()
    
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

}
