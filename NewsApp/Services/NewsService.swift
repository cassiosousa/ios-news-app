import Foundation

final class NewsService {
    private let serviceManager = ServiceManager()
    
    func fetch(byCountry country: String? = nil, completion: @escaping (Result<News,NetworkError>) -> Void) {
        let filterBy = prepareQueryParameters(byCountry: country)
        let resource = Resource<News>(url: URL(string: "https://newsapi.org/v2/top-headlines?\(filterBy)category=business&pageSize=35&apiKey=")!)
        serviceManager.fetch(resource: resource, completion: completion)
    }
    
    func prepareQueryParameters(byCountry: String? = nil) -> String{
        guard let byCountry = byCountry else { return "" }
        return "country=\(byCountry)&"
    }
}
