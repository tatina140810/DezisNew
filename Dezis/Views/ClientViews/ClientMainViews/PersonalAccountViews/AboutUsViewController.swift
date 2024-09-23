//
//  AboutUsViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 22/9/24.
//

import UIKit

class AboutUsViewController: UIViewController {
    private var settingsTitleLabel = LabelSettings().labelMaker(text: "О Нас")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(settingsTitleLabel)
        NSLayoutConstraint.activate([
            settingsTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }

    }
    

