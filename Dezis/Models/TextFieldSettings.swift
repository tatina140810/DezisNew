import UIKit

class TextFieldSettings: UITextField {
    
    func textFieldMaker(placeholder: String, backgroundColor: UIColor = UIColor(hex: "#F6F6F7"), cornerRadius: CGFloat = 8, constraints: Bool = false
    ) -> UITextField {
        
        let tetField = UITextField()
        tetField .placeholder = placeholder
        tetField .backgroundColor = backgroundColor
        tetField .layer.cornerRadius = cornerRadius
        tetField .translatesAutoresizingMaskIntoConstraints = constraints
        return  tetField
    }
}
