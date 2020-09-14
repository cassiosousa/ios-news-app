import UIKit

final class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageCountry: UIImageView!
    @IBOutlet private weak var viewCountry: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI(){
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        self.viewCountry.fixInView(self)
        self.imageCountry.round(size: 5)
        self.imageCountry.clipsToBounds = true
    }
}
