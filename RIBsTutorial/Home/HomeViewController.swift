import Anchorage
import RIBs
import RxSwift
import UIKit

///@mockable
protocol HomePresentableListener: class {
    func didTapLogout()
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {

    weak var listener: HomePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let closeButton = UIButton()
        closeButton.setTitle("Log out", for: .normal)
        closeButton.backgroundColor = .blue
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        view.addSubview(closeButton)
        closeButton.centerYAnchor == view.centerYAnchor
        closeButton.horizontalAnchors == view.horizontalAnchors + 16
        closeButton.heightAnchor == 40
    }
    
    @objc private func close() {
        listener?.didTapLogout()
    }
}
