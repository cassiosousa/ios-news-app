import UIKit

final class BrowseNewsViewController: UIViewController {
    
    @IBOutlet private weak var collectionViewCountry: UICollectionView!
    @IBOutlet private weak var viewBottom: UIView!
    @IBOutlet private weak var labelCountry: UILabel!
    
    @IBOutlet private weak var newsCardView: NewsCardView!
    @IBOutlet private weak var categoryView: CategoryView!
    
    private let collectionViewCellCountryId = "collectionViewCellCountryId"
    private let collectionViewCellCountryIdExcception = "collectionViewCellCountryIdException"
    private let browseNewsListViewModel = BrowseNewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiSetup()
        self.searchNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        categoryView.selectFirst()
        selectFirstCountry()
    }
    
    private func uiSetup() {
        self.navigationItem.title = "Browse"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewBottom.roundedTop(size: 40)
        collectionViewCountry.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellCountryId)
        collectionViewCountry.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellCountryIdExcception)
        collectionViewCountry.dataSource = self
        collectionViewCountry.delegate = self
        categoryView.delegate = self
    }
    
    private func backgroundGradient() {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        let firstColor = UIColor(red: 1.00, green: 0.98, blue: 0.98, alpha: 1.00) //#fffbfa
        let secondColor = UIColor(red: 0.95, green: 0.94, blue: 0.93, alpha: 1.00) //#f3efee
        gradient.colors = [firstColor.cgColor,secondColor.cgColor]
        self.view.layer.insertSublayer(gradient, at:0)
    }
    
    private func changeCountry( name: String) {
        let title =  "Country - \(name.capitalized)"
        guard let indexAt = title.firstIndex(of: "-") else { return }
        let location = title.distance(from: title.startIndex, to:  indexAt)
        let font = UIFont(name: "Avenir-MediumOblique", size: 18)
        
        let atrributedName = NSMutableAttributedString(string: title)
        atrributedName.addAttribute(.font, value: font, range: NSRange(location: location, length: name.count))
        
        labelCountry.attributedText = atrributedName
    }
    
    private func findNewsBy(country: String){
        newsCardView.search(country)
    }
    
    private func findNewsBy(category: String){
        newsCardView.search(category: category)
    }
    
    private func searchNews() {
        newsCardView.search(browseNewsListViewModel.firstKeyFlag(), category: categoryView.firstCategory.category.rawValue)
    }
    
    private func selectFirstCountry() {
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = collectionViewCountry.cellForItem(at: indexPath) as? CountryCollectionViewCell else { return }
        cell.addBorderToSelectCountry()
        self.collectionViewCountry.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        self.changeCountry(name: browseNewsListViewModel.firstValueFlag())
    }
}


// MARK: UICollectionViewDataSource
extension BrowseNewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return browseNewsListViewModel.numbersOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellCountryId, for: indexPath) as? CountryCollectionViewCell,
              let flag = browseNewsListViewModel.flagAt(index: indexPath.row)
        else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellCountryIdExcception, for: indexPath)
                .notFound(label: "Not found CountryCollectionViewCell")
        }
        cell.associate(flag: flag)
        return cell
    }
}


// MARK: UICollectionViewDataSource
extension BrowseNewsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let countryName = browseNewsListViewModel.flagAt(index: indexPath.row)
        let countryKey = browseNewsListViewModel.flagKey(index: indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as! CountryCollectionViewCell
        cell.addBorderToSelectCountry()
        changeCountry(name: countryName ?? "")
        findNewsBy(country: countryKey ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CountryCollectionViewCell
        cell.removeBorderToSelectedCountry()
    }
}


// MARK: CategoryViewDelegate
extension BrowseNewsViewController: CategoryViewDelegate {
    func categoryView(didSelectCategory: CategoryViewModel) {
        self.findNewsBy(category: didSelectCategory.category.rawValue.lowercased())
    }
    
}
