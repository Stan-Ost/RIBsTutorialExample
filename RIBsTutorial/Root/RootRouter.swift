import RIBs

///@mockable
protocol RootInteractable: Interactable, LoginListener, HomeListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

///@mockable
protocol RootViewControllable: ViewControllable {
    func replaceScreen(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let loginBuilder: LoginBuildable
    private var loginRouter: LoginRouting?
    private let homeBuilder: HomeBuildable
    private var homeRouter: HomeRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        loginBuilder: LoginBuildable,
        homeBuilder: HomeBuildable
    ) {
        self.loginBuilder = loginBuilder
        self.homeBuilder = homeBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachLogin() {
        if let homeRouter = homeRouter {
            detachChild(homeRouter)
            self.homeRouter = nil
        }
        
        guard loginRouter == nil else { return }
        let router = loginBuilder.build(withListener: interactor)
        attachChild(router)
        loginRouter = router
        viewController.replaceScreen(viewController: router.viewControllable)
    }
    
    func attachHome() {
        if let loginRouter = loginRouter {
            detachChild(loginRouter)
            self.loginRouter = nil
        }
        
        guard homeRouter == nil else { return }
        let router = homeBuilder.build(withListener: interactor)
        attachChild(router)
        homeRouter = router
        viewController.replaceScreen(viewController: router.viewControllable)
    }
}
