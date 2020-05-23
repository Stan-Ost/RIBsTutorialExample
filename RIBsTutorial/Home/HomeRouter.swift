import RIBs

///@mockable
protocol HomeInteractable: Interactable {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

///@mockable
protocol HomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: HomeInteractable, viewController: HomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
