import RIBs

final class AppComponent: Component<EmptyDependency>, RootDependency {
    var webService: WebServicing
    
    init() {
        webService = WebService()
        super.init(dependency: EmptyComponent())
    }
}
