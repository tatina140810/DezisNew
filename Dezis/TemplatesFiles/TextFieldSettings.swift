import UIKit

class TextFieldSettings: UITextField {
    
    func textFieldMaker(
        placeholder: String,
        placeholderColor: UIColor = UIColor(hex: "#B0B0B0"),
        backgroundColor: UIColor = UIColor(hex: "#F6F6F7"),
        textColor: UIColor = .white,
        cornerRadius: CGFloat = 8,
        autocapitalizationType: UITextAutocapitalizationType = .none

    ) -> UITextField {
        
        let textField = UITextField()
        
        textField.backgroundColor = backgroundColor
        textField.textColor = textColor
        textField.layer.cornerRadius = cornerRadius
        textField.autocapitalizationType = .none
        
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
