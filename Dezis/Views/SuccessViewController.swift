//
//  SuccessViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 18/9/24.
//

import UIKit

class SuccessViewController: UIViewController {
    
    private var checkImage = ImageSettings().imageMaker(image: UIImage(resource: .checkCircle))
        
 var titleLabel = LabelSettings().labelMaker(text: "Вы успешно авторизовались!", font:  UIFont.systemFont(ofSize: 20))
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

       setupUI()
    }
    
    private func setupUI(){
        view.addSubview(checkImage)
        NSLayoutConstraint.activate([
            checkImage.bottomAnchor.constraint(equalTo: view.centerYAnchor,constant: -50),
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
}
