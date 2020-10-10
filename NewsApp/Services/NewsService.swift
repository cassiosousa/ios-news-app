import Foundation

final class NewsService {
    
    func fetch(byCountry country: String? = nil,byCategory category: String? = nil, completion: @escaping (Result<News,NetworkError>) -> Void) {
        let baseUrl = Parameters.shared.baseUrl
        let pathTopHeadlines = Parameters.shared.pathTopHeadlines
        let parameters = prepareQueryParameters(byCountry: country, byCategory: category)
        guard let url = URL(string: "\(baseUrl)\(pathTopHeadlines)") else {
            completion(.failure(.urlError))
            return
        }
        let resource = Resource<News>(url: url,queryParameters: parameters)
        ServiceManager.shared.fetch(resource: resource, completion: completion)
    }
    
    func prepareQueryParameters(byCountry: String? = nil, byCategory: String? = nil) -> [String:String]{
        var parameters: [String:String] = [:]
        if let byCountry = byCountry {
            parameters["country"] = byCountry
        
        }
        if let byCategory = byCategory {
            parameters["category"] = byCategory
        
        }
        parameters["pageSize"] = Parameters.shared.defaultPageSize
        parameters["apiKey"] = Parameters.shared.key
        return parameters
    }
}
