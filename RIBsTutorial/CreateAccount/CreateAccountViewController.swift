import Anchorage
import RIBs
import RxSwift
import UIKit

///@mockable
protocol CreateAccountPresentableListener: class {
    func didTapClose()
}

final class CreateAccountViewController: UIViewController, CreateAccountPresentable, CreateAccountViewControllable {

    weak var listener: CreateAccountPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let closeButton = UIButton()
        closeButton.setTitle("Close create account", for: .normal)
        closeButton.backgroundColor = .blue
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        view.addSubview(closeButton)
        closeButton.centerYAnchor == view.centerYAnchor
        closeButton.horizontalAnchors == view.horizontalAnchors + 16
        closeButton.heightAnchor == 40
    }
    
    @objc private func close() {
        listener?.didTapClose()
    }
}
