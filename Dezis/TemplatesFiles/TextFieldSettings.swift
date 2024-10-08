import UIKit

class TextFieldSettings: UITextField {
    
    func textFieldMaker(
        placeholder: String,
        placeholderColor: UIColor = UIColor.white,
        backgroundColor: UIColor = UIColor(hex: "#F6F6F7"),
        cornerRadius: CGFloat = 8,
        constraints: Bool = false
    ) -> UITextField {
        
        let textField = UITextField()
        
    
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = cornerRadius
        textField.translatesAutoresizingMaskIntoConstraints = constraints
        
      
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
      
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }
}

