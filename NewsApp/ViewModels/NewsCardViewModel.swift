import Foundation

struct NewsCardListViewModel {
    private let newsCardViewModel: [NewsCardViewModel]
    
    
    init( newsCardViewModel: [NewsCardViewModel]) {
        self.newsCardViewModel = newsCardViewModel
    }
}

struct NewsCardViewModel {
    private var article: Articles
    
    init(_ article: Articles) {
        self.article = article
    }
}


extension NewsCardListViewModel {
    
    var numbersOfSection: Int {
        return 1
    }
    
    var numbersOfItemsInSection: Int {
        return self.newsCardViewModel.count
    }
    
    func articleAt(index: Int) -> NewsCardViewModel {
        return self.newsCardViewModel[index]
    }
}


extension NewsCardViewModel {
    var title: String {
        return article.title
    }
    
    var author: String {
        return article.author ?? ""
    }
    
    var description: String {
        return article.description ?? ""
    }
    
    var url: String {
        return article.url ?? ""
    }
    
    var image: String {
        return article.urlToImage ?? ""
    }
    
    var publishedAt: String {
        return article.formatedPublishedAt()
    }
}
