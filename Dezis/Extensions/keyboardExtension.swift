//
//  keyboardExtension.swift
//  Dezis
//
//  Created by Nurtilek on 11/6/24.
//

import UIKit

extension UIViewController {
    
    func dismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
