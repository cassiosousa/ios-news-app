
import Foundation
import UIKit

extension UICollectionViewCell {
    func notFound(label: String = "Not Found") -> UICollectionViewCell{
        let title = UILabel()
        title.text = label
        title.font = UIFont(name: "AvenirNext-Bold", size: 15)
        title.textAlignment = .center
        title.frame = self.bounds
        title.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.addSubview(title)
        return self
    }
}
