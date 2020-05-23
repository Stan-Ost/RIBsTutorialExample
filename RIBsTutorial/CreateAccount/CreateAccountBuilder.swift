import RIBs

///@mockable
protocol CreateAccountDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CreateAccountComponent: Component<CreateAccountDependency> {
}

// MARK: - Builder

///@mockable
protocol CreateAccountBuildable: Buildable {
    func build(withListener listener: CreateAccountListener) -> CreateAccountRouting
}

final class CreateAccountBuilder: Builder<CreateAccountDependency>, CreateAccountBuildable {

    override init(dependency: CreateAccountDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CreateAccountListener) -> CreateAccountRouting {
        _ = CreateAccountComponent(dependency: dependency)
        let viewController = CreateAccountViewController()
        let interactor = CreateAccountInteractor(presenter: viewController)
        interactor.listener = listener
        return CreateAccountRouter(interactor: interactor, viewController: viewController)
    }
}
