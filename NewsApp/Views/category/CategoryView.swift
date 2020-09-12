
import Foundation
import UIKit

final class CategoryView: UIView {
    @IBOutlet private var categoryView: UIView!
    @IBOutlet private weak var collectionViewCategory: UICollectionView!
    @IBOutlet private weak var collectionViewFlowLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private let cellCategoryViewIdentifier = "CellCategoryView"
    private let categoryListViewModel = CategoryListViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
            self.categoryView.fixInView(self)
        collectionViewCategory.dataSource = self
        collectionViewCategory.delegate = self
        collectionViewCategory.register(CategoryCellView.self, forCellWithReuseIdentifier: cellCategoryViewIdentifier)
    }
}

// MARK: UICollectionViewDataSource
extension CategoryView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoryListViewModel.numbersOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryListViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellCategoryViewIdentifier, for: indexPath) as! CategoryCellView
        cell.associateData(category: categoryListViewModel.categoryAt(index: indexPath.row))
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CategoryView: UICollectionViewDelegate {
}
