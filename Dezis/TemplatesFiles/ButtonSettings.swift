import UIKit

class ButtonSettings: UIButton {
    func buttonMaker(title: String = "Button",
                     titleColor: UIColor = .white,
                     backgroundColor: UIColor = UIColor(hex: "#0A84FF"),
                     target: Any?,
                     action: Selector,
                     for controlEvent: UIControl.Event = .touchUpInside,
                     constraints: Bool = false
    ) -> UIButton {
        
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.borderColor = UIColor(hex: "#0A84FF").cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.addTarget(target, action: action, for: controlEvent)
        
      button.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 16)
        
        return button
    }
}
