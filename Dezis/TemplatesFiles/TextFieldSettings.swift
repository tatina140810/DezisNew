import UIKit

class TextFieldSettings: UITextField {
    
    func textFieldMaker(
        placeholder: String,
        placeholderColor: UIColor = .white,
        backgroundColor: UIColor = UIColor(hex: "#F6F6F7"),
        textColor: UIColor = .white,
        cornerRadius: CGFloat = 8
       // borderStyle: UITextField.BorderStyle = .line,
       // borderColor: UIColor = UIColor(hex:  "#2B373E"),
       // borderWidth: CGFloat = 1.0
    ) -> UITextField {
        
        let textField = UITextField()
        
        textField.backgroundColor = backgroundColor
        textField.textColor = textColor
        textField.layer.cornerRadius = cornerRadius
       // textField.borderStyle = borderStyle
      //  textField.layer.borderColor = borderColor.cgColor
       // textField.layer.borderWidth = borderWidth
        
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
