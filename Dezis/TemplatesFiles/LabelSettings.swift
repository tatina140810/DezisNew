import UIKit

class LabelSettings: UILabel {
    
    func labelMaker(text: String, font: UIFont = UIFont(name: " SFProText-Bold", size: 16)!,
                    textColor: UIColor = .black,
                    textAligmat: NSTextAlignment = .left,
                    numberOfLines: Int = 0,
                    constraints: Bool = false
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAligmat
        label.numberOfLines = numberOfLines
        
        
        return label
    }
}
