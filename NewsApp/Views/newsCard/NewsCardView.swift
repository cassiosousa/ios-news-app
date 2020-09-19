
import Foundation
import UIKit

final class NewsCardView: UIView {
    @IBOutlet private var newsCardCellView: UIView!
    @IBOutlet private weak var collectionViewNews: UICollectionView!
    @IBOutlet private weak var collectionViewFlowLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private let newsCardViewViewIdentifier = "NewsCardCellView"
    private var newsCardListViewModel = NewsCardListViewModel(newsCardViewModel:[])
    private var country: String = ""
    private var category: String = ""
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
        self.newsCardCellView.fixInView(self)
        collectionViewNews.dataSource = self
        collectionViewNews.delegate = self
        collectionViewNews.register(NewsCardCellView.self, forCellWithReuseIdentifier: newsCardViewViewIdentifier)
    }
    
    func search(_ country: String? = nil,category: String? = nil) {
        self.country = country ?? self.country
        self.category = category ?? self.category
        self.loadData(country: self.country, category: self.category)
    }
    
    private func loadData(country: String? = nil, category: String? = nil) {
        NewsService().fetch(byCountry: country, byCategory: category) { result in
            let news =  try? result.get()
            self.newsCardListViewModel = NewsCardListViewModel(newsCardViewModel: news?.articles.map(NewsCardViewModel.init) ?? [])
            DispatchQueue.main.async {
                self.collectionViewNews.reloadData()
                self.collectionViewNews.scrollToItem(at: IndexPath.init(index: .min), at: .left, animated: true)
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension NewsCardView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return newsCardListViewModel.numbersOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsCardListViewModel.numbersOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsCardViewViewIdentifier, for: indexPath) as! NewsCardCellView
        cell.associateData(newsCard: newsCardListViewModel.articleAt(index: indexPath.row))
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension NewsCardView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 400)
    }
}
