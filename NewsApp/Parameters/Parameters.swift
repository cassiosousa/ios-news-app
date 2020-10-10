
import UIKit

final class Parameters {
    static let shared = Parameters()
    
    private(set) var baseUrl: String = ""
    private(set) var key: String = ""
    private(set) var pathTopHeadlines: String = ""
    private(set) var defaultPageSize: String = ""
    
    private init() {
        self.read()
    }
    
    private func read() {
        guard let plist = self.getPlist(withName: "development"),
              let url = plist["baseUrl"],
              let key = plist["key"],
              let pathTopHeadlines = plist["pathTopHeadlines"],
              let defaultPageSize = plist["defaultPageSize"] else {
            return;
        }
        self.baseUrl = url
        self.key = key
        self.pathTopHeadlines = pathTopHeadlines
        self.defaultPageSize = defaultPageSize
    }
    
    private func getPlist(withName name: String) ->Dictionary<String, String>?
    {
        if let path = Bundle.main.path(forResource: name, ofType: "plist") {
            return NSDictionary(contentsOfFile: path) as? Dictionary<String, String>
        }
        return .none
    }
}
