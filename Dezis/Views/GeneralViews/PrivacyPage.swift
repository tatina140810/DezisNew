//
//  PrivacyPage.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 29/10/24.
//

import UIKit

class PrivacyPage: UIViewController {
    private var privacyLabel: UILabel = {
        let view = UILabel()
        view.text = "Условие продажи"
        view.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        
        
    }
    func setupUI(){
        view.addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
}
