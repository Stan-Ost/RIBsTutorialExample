import RIBs

///@mockable
protocol LoginInteractable: Interactable, CreateAccountListener {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

///@mockable
protocol LoginViewControllable: ViewControllable {
    func present(_ viewController: ViewControllable)
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>, LoginRouting {

    private let createAccountBuilder: CreateAccountBuildable
    private var createAccountRouter: CreateAccountRouting?
    
    init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable,
        createAccountBuilder: CreateAccountBuildable
    ) {
        self.createAccountBuilder = createAccountBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToCreateAccount() {
        guard createAccountRouter == nil else { return }
        let router = createAccountBuilder.build(withListener: interactor)
        attachChild(router)
        createAccountRouter = router
        router.viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        viewController.present(router.viewControllable)
    }
    
    func detachCreateAccount() {
        guard let createAccountRouter = createAccountRouter else { return }
        detachChild(createAccountRouter)
        createAccountRouter.viewControllable.uiviewController.dismiss(animated: true, completion: nil)
        self.createAccountRouter = nil
    }
}
