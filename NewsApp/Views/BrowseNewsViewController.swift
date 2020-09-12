import UIKit

final class BrowseNewsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiSetup()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        backgroundGradient()
    }
    
    private func uiSetup() {
        self.navigationItem.title = "Browse"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    private func backgroundGradient() {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.view.bounds
        let firstColor = UIColor(red: 1.00, green: 0.98, blue: 0.98, alpha: 1.00) //#fffbfa
        let secondColor = UIColor(red: 0.95, green: 0.94, blue: 0.93, alpha: 1.00) //#f3efee
        gradient.colors = [firstColor.cgColor,secondColor.cgColor]
        self.view.layer.insertSublayer(gradient, at:0)
    }
}
