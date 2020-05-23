import RIBs
import RxSwift

///@mockable
protocol RootRouting: ViewableRouting {
    func attachLogin()
    func attachHome()
}

///@mockable
protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

///@mockable
protocol RootListener: class {
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        router?.attachLogin()
    }

    // MARK: - LoginListener
    
    func dismissLoginFlow() {
        router?.attachHome()
    }
    
    // MARK: - HomeListener
    
    func logout() {
        router?.attachLogin()
    }
}
