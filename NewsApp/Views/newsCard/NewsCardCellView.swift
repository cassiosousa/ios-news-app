
import Foundation
import UIKit

final class NewsCardCellView: UICollectionViewCell {
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var newsCardCellView: UIView!
    @IBOutlet private weak var buttonSee: UIButton!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var labelDate: UILabel!
    
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
        self.newsCardCellView.fixInView(self)
        self.newsCardCellView.layer.cornerRadius = 40
        self.newsCardCellView.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 40)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 20
        self.newsCardCellView.layer.masksToBounds = true
        buttonSee.round()
        
    }
    
    override func layoutSubviews() {
        labelTitle.sizeToFit()
    }
    
    func associateData(newsCard: NewsCardViewModel) {
        labelTitle.text = newsCard.title
        image.download(urlImage: newsCard.image)
        labelDate.text = newsCard.publishedAt
    }
}
