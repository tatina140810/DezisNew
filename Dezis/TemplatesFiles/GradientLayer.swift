import UIKit

class GradientLayer: CAGradientLayer {

    override init() {
        super.init()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    private func setupGradient() {
        
        frame = bounds
        colors = [
            UIColor(hex: "#1599EE").cgColor,
            UIColor(hex: "#0C5888").cgColor
        ]
       
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 1)
    }
}
