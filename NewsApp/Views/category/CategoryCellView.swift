
import Foundation
import UIKit

final class CategoryCellView: UICollectionViewCell {
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet var categoryCellView: UIView!
    
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
        self.categoryCellView.fixInView(self)
    }
    
    func associateData(category: CategoryViewModel) {
        labelCategory.text = category.name
    }
}
