import UIKit

final class BrowseNewsViewController: UIViewController {
    
    @IBOutlet weak var collectionViewCountry: UICollectionView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var labelCountry: UILabel!
    
    @IBOutlet weak var newsCardView: NewsCardView!
    
    private let collectionViewCellCountryId = "collectionViewCellCountryId"
    private let browseNewsListViewModel = BrowseNewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundGradient()
    }
    
    private func uiSetup() {
        self.navigationItem.title = "Browse"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewBottom.roundedTop(size: 40)
        collectionViewCountry.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellCountryId)
        collectionViewCountry.dataSource = self
        collectionViewCountry.delegate = self
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
        newsCardView.change(country: country)
    }
}


// MARK: UICollectionViewDataSource
extension BrowseNewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return browseNewsListViewModel.numbersOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellCountryId, for: indexPath) as! CountryCollectionViewCell
        cell.associate(flag: browseNewsListViewModel.flagAt(index: indexPath.row))
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
        changeCountry(name: countryName)
        findNewsBy(country: countryKey)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CountryCollectionViewCell
        cell.removeBorderToSelectedCountry()
    }
}
