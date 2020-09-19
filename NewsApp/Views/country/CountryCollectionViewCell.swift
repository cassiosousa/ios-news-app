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
    
    private func setupUI(){
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        self.viewCountry.fixInView(self)
        self.imageCountry.round(size: 5)
        self.imageCountry.clipsToBounds = true
        
    }
    
    func associate(flag: String){
        imageCountry.image = UIImage(named: flag)
    }
    
    func addBorderToSelectCountry() {
        self.viewCountry.layer.cornerRadius = 5
        self.viewCountry.layer.borderWidth = 3
        self.viewCountry.layer.borderColor = UIColor.white.cgColor
    }
    
    func removeBorderToSelectedCountry() {
        self.viewCountry.layer.borderWidth = 0
    }
}
