import UIKit

class LabelSettings: UILabel {
    
    func labelMaker(text: String, font: UIFont = .boldSystemFont(ofSize: 16),
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
        label.translatesAutoresizingMaskIntoConstraints = constraints
        
        return label
    }
}
