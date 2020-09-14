import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles:[Articles]
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct Articles: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    let source: Source?
    
    func formatedPublishedAt() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yy HH:mm"
        return formatter.string(from: publishedAt)
    }
}
