import Foundation

enum NetworkError: Error {
    case domainError
    case urlError
    case decodingError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T:Codable> {
    let url: URL
    var httpMethod = HttpMethod.get
    private var queryParameters: [String:String] = [:]
    var body: Data? = nil
    
    init(url: URL) {
        self.url = url
    }
    
    init(url: URL, queryParameters: [String:String]) {
        self.url = url
        self.queryParameters = queryParameters
    }
    
    func urlQueryItems() -> [URLQueryItem] {
        return queryParameters.map({key,value in
            URLQueryItem(name: key, value: value)
        })
    }
    
    mutating func addQueryParameter(key:String, value:String ){
        queryParameters[key] = value
    }
}

final class ServiceManager {
    static var shared = ServiceManager()
    
    private init() {}
    
    func fetch<T>(resource: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> Void) {
        guard let urlComponents = URLComponents(url: resource.url, resolvingAgainstBaseURL: false),
              let urlRequest = createRequest(resource, urlComponents) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest){data,response,error in
            guard let data = data,
                let _ = response,
                error == nil else {
                    completion(.failure(.domainError))
                    return
            }
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            decoder.dateDecodingStrategy = .formatted(formatter)
            let result = try? decoder.decode(T.self, from: data)
            
            if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    
    private func createRequest<T>(_ resource: Resource<T>,_ urlComponents: URLComponents) -> URLRequest? {
        let type = "application/json"
        var components = urlComponents
        components.queryItems = resource.urlQueryItems()
        guard let url = components.url else { return .none }
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod.rawValue
        request.addValue(type, forHTTPHeaderField: "Content-type")
        request.addValue(type, forHTTPHeaderField: "Accept")
        return request
    }
}
