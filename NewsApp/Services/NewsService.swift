import Foundation

class NewsService {
    private let serviceManager = ServiceManager()
    
    func fetch(completion: @escaping (Result<News,NetworkError>) -> Void) {
        let resource = Resource<News>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&pageSize=35&apiKey=")!)
        serviceManager.fetch(resource: resource, completion: completion)
    }
}
