import RIBs
import RxSwift

///@mockable
protocol HomeRouting: ViewableRouting {
}

///@mockable
protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
}

///@mockable
protocol HomeListener: class {
    func logout()
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {

    weak var router: HomeRouting?
    weak var listener: HomeListener?

    override init(presenter: HomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    // MARK: - HomePresentableListener
    
    func didTapLogout() {
        listener?.logout()
    }
}
