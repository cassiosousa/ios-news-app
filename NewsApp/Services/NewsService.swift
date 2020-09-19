import Foundation

final class NewsService {
    private let serviceManager = ServiceManager()
    
    func fetch(byCountry country: String? = nil,byCategory category: String? = nil, completion: @escaping (Result<News,NetworkError>) -> Void) {
        let filterBy = prepareQueryParameters(byCountry: country, byCategory: category)
        let resource = Resource<News>(url: URL(string: "https://newsapi.org/v2/top-headlines?\(filterBy)pageSize=10&apiKey=")!)
        serviceManager.fetch(resource: resource, completion: completion)
    }
    
    func prepareQueryParameters(byCountry: String? = nil, byCategory: String? = nil) -> String{
        var filters =  ""
        if let byCountry = byCountry {
            filters.append("country=\(byCountry)&")
        
        }
        if let byCategory = byCategory {
            filters.append("category=\(byCategory)&")
        
        }
        return filters
    }
}
