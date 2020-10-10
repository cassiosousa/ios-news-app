import UIKit

private let cache = NSCache<NSString, NSData>()

extension UIImageView
{
    func download(urlImage: String) {
        self.image = UIImage(named: "placeHolderImage")
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = self.bounds
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        cacheImage(urlImage, activityIndicator)
    }
    
    private func cacheImage(_ urlImage: String,_ activityIndicator: UIActivityIndicatorView) {
        guard let url = URL(string:urlImage) else{return}
        if let image = cache.object(forKey: NSString(string:urlImage)) {
            DispatchQueue.main.async {
                self.image = UIImage(data: image as Data)
                activityIndicator.removeFromSuperview()
            }
        }else{
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                        self.alpha = 0
                        UIView.animate(withDuration: 1.5) {
                            self.alpha = 1
                        }
                        cache.setObject(data as NSData, forKey: NSString(string: urlImage ))
                        activityIndicator.removeFromSuperview()
                    }
                }
            }
        }
    }
}
