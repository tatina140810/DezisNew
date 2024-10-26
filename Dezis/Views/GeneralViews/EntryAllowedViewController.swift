//
//  EntryAllowedViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 13/10/24.
//

import UIKit

class EntryAllowedViewController: UIViewController {

    private var entryAllowedImage: UIImageView = {
           let view = UIImageView()
        view.image = UIImage(resource: .entryAllowed)
           return view
       }()
       private var titleLabel: UILabel = {
           let view = UILabel()
           view.text = "Пожалуйста, подождите пока администратор даст вам разрешение на вход в приложение!"
           view.font = UIFont(name: "SFProDisplay-Regular", size: 16)
           view.textAlignment = .center
           view.textColor = .white
           view.numberOfLines = 0
           return view
       }()


       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = UIColor(hex: "#1B2228")
           setupUI()
           DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                      self?.loadNextViewController()
                  }

           }
       
       private func setupUI(){
           
           view.addSubview(entryAllowedImage)
           entryAllowedImage.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(152)
               make.centerX.equalToSuperview()
               make.height.width.equalTo(276)
              
           }
           view.addSubview(titleLabel)
           titleLabel.snp.makeConstraints { make in
               make.top.equalTo(entryAllowedImage.snp.bottom).offset(24)
               make.leading.trailing.equalToSuperview().inset(45)
           }
       }
    private func loadNextViewController() {
        let vc = ClientTabBarController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
   }




