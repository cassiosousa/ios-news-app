
import Foundation
import UIKit

protocol CategoryViewDelegate: class {
    func categoryView(didSelectCategory: CategoryViewModel)
}

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
    
    weak var delegate: CategoryViewDelegate?
    
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

// MARK: Computed Properties
extension CategoryView {
    
    
    var firstCategory : CategoryViewModel {
        return categoryListViewModel.categoryAt(index: 0)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        let category = categoryListViewModel.categoryAt(index: indexPath.row)
        delegate.categoryView(didSelectCategory: category)
    }
}
