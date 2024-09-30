import UIKit

class TextFieldSettings: UITextField {
    
    func textFieldMaker(placeholder: String, backgroundColor: UIColor = UIColor(hex: "#F6F6F7"), cornerRadius: CGFloat = 8, constraints: Bool = false) -> UITextField {
        
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = cornerRadius
        textField.translatesAutoresizingMaskIntoConstraints = constraints
        
       
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }
}

