import UIKit

class ImageSettings: UIImageView {
    
    func imageMaker(image: UIImage?,
                    tintColor: UIColor = UIColor.black,
                    backgroundColor: UIColor = UIColor.clear,
                    constraints: Bool = false
    ) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = tintColor
        imageView.backgroundColor = backgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = constraints
        
        return imageView
    }
}

