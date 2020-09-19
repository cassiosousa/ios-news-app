
import Foundation
import UIKit

final class CategoryCellView: UICollectionViewCell {
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet var categoryCellView: UIView!
    @IBOutlet weak var selectedMark: UIView!
    
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
        self.selectedMark.round()
        self.selectedMark.isHidden = true
    }
    
    func associateData(category: CategoryViewModel) {
        labelCategory.text = category.name
        self.selectedMark.isHidden = true
    }
    
    func showSelectedDetail() {
        self.selectedMark.isHidden = false
    }
    
    func hideSelectedDetail() {
        self.selectedMark.isHidden = true
    }
}
