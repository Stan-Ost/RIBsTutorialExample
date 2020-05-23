import Anchorage
import RIBs
import RxSwift
import UIKit

///@mockable
protocol RootPresentableListener: class {
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    private var currentViewController: ViewControllable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    // MARK: - RootViewControllable
    
    func replaceScreen(viewController: ViewControllable) {
        viewController.uiviewController.willMove(toParent: self)
        addChild(viewController.uiviewController)
        view.addSubview(viewController.uiviewController.view)
        viewController.uiviewController.view.edgeAnchors == view.edgeAnchors
        currentViewController?.uiviewController.willMove(toParent: nil)
        currentViewController?.uiviewController.view.removeFromSuperview()
        currentViewController?.uiviewController.removeFromParent()
        viewController.uiviewController.didMove(toParent: self)
        currentViewController = viewController
    }
}
