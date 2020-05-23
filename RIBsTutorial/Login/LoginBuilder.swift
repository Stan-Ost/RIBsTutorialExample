//
//  LoginBuilder.swift
//  RIBsTutorial
//
//  Created by Stanislav Ostrovskiy on 5/21/20.
//  Copyright © 2020 Stanislav Ostrovskiy. All rights reserved.
//

import RIBs

///@mockable
protocol LoginDependency: CreateAccountDependency {
    var webService: WebServicing { get }
}

final class LoginComponent: Component<LoginDependency> {
}

// MARK: - Builder

///@mockable
protocol LoginBuildable: Buildable {
    func build(withListener listener: LoginListener) -> LoginRouting
}

final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoginListener) -> LoginRouting {
        let component = LoginComponent(dependency: dependency)
        let viewController = LoginViewController()
        let interactor = LoginInteractor(presenter: viewController, webService: component.dependency.webService)
        interactor.listener = listener
        
        let createAccountBuilder = CreateAccountBuilder(dependency: component.dependency)
        
        return LoginRouter(
            interactor: interactor,
            viewController: viewController,
            createAccountBuilder: createAccountBuilder
        )
    }
}
