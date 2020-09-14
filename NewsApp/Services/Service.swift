import Foundation

enum NetworkError: Error {
    case domainError
    case decodingError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource<T:Codable> {
    let url: URL
    var httpMethod = HttpMethod.get
    var body: Data? = nil
    
    init(url: URL) {
        self.url = url
    }
}

final class ServiceManager {
    func fetch<T>(resource: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request){data,response,error in
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
}
