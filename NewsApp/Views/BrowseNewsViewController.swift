import UIKit

final class BrowseNewsViewController: UIViewController {
    
    @IBOutlet weak var collectionViewCountry: UICollectionView!
    @IBOutlet weak var viewBottom: UIView!
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
        collectionViewCountry.register(CountryCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCellCountryId")
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
}

extension BrowseNewsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCellCountryId", for: indexPath)
    }
}
