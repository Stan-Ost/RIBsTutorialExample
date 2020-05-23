import RIBs
import RxSwift

///@mockable
protocol LoginRouting: ViewableRouting {
    func routeToCreateAccount()
    func detachCreateAccount()
}

///@mockable
protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
    func showActivityIndicator(_ isLoading: Bool)
    func showErrorAlert()
}

///@mockable
protocol LoginListener: class {
    func dismissLoginFlow()
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {

    weak var router: LoginRouting?
    weak var listener: LoginListener?
    
    private let webService: WebServicing

    init(presenter: LoginPresentable, webService: WebServicing) {
        self.webService = webService
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: - LoginPresentableListener
    
    func didTapLogin(username: String, password: String) {
        presenter.showActivityIndicator(true)
        webService.login(
            username: username,
            password: password) { [weak self] result in
                self?.presenter.showActivityIndicator(false)
                switch result {
                case .success:
                    self?.listener?.dismissLoginFlow()
                case .failure:
                    self?.presenter.showErrorAlert()
                }
        }
    }
    
    func didTapCreateAccount() {
        router?.routeToCreateAccount()
    }
    
    // MARK: - CreateAccountListener
    
    func closeCreateAccountFlow() {
        router?.detachCreateAccount()
    }
}
