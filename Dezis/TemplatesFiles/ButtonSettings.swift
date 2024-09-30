import UIKit

class ButtonSettings: UIButton {
    func buttonMaker(title: String = "Button",
                     titleColor: UIColor = .white,
                     backgroundColor: UIColor = UIColor(hex: "#5191BA"),
                     target: Any?,
                     action: Selector,
                     for controlEvent: UIControl.Event = .touchUpInside,
                     constraints: Bool = false
    ) -> UIButton {
        
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 8
        button.addTarget(target, action: action, for: controlEvent)
        button.translatesAutoresizingMaskIntoConstraints = constraints
        
        return button
    }
}
