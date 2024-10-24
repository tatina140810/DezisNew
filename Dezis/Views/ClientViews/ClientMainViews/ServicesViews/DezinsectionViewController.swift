//
//  DezinsectionViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 2/10/24.
//

import UIKit

class DezinsectionViewController: UIViewController {
    
        private var dezincectionImage:UIImageView = {
            let view = UIImageView()
            view.image = UIImage(resource: .rectangle454)
            view.layer.cornerRadius = 12
            view.clipsToBounds = true
            return view
            
        }()
        private var titleLable: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.text = "Дезинсекция"
            label.textColor = .white
            return label
        }()
        
        private var servicesDescriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Дезинсекция — это профессиональное уничтожение любых видов вредителей, таких как тараканы, муравьи, клопы, моль и другие насекомые. Мы применяем современные и безопасные методы обработки, чтобы гарантировать полное избавление от вредителей в жилых и коммерческих помещениях. Наши специалисты проводят тщательный анализ для выявления очагов заражения и используют эффективные средства для устранения проблемы."
            label.textAlignment = .left
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label
        }()
        
    private lazy var orderButton: UIButton = {
            let button = UIButton()
            button.setTitle("Заказать услугу", for: .normal)
            button.backgroundColor = UIColor(hex: "#0A84FF")
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            return button
            
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            view.backgroundColor = UIColor(hex: "#1B2228")

            
        }
        private func setupUI(){
            view.addSubview(titleLable)
            titleLable.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(60)
                make.centerX.equalToSuperview()
            }
            view.addSubview(dezincectionImage)
            dezincectionImage.snp.makeConstraints { make in
                make.top.equalTo(titleLable.snp.bottom).offset(20)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(300)
            }
          
            view.addSubview(servicesDescriptionLabel)
            servicesDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(dezincectionImage.snp.bottom).offset(20)
                make.leading.equalToSuperview().offset(14)
                make.trailing.equalToSuperview().offset(-14)
            }
            view.addSubview(orderButton)
            orderButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-100)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(50)
            }
        }
        @objc func orderButtonTapped(){
            let vc = ViewControllerForAlert()
        
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }

    }
