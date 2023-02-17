//
//  AppRootBuilder.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency>, LoggedOutDependency, LoggedInDependency {
    var LoggedInViewController: LoggedInViewControllable
    
    let appRootViewController: AppRootViewController
    
    init(dependency: AppRootDependency,
         appRootViewController: AppRootViewController)
    {
        LoggedInViewController = appRootViewController
        self.appRootViewController = appRootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = AppRootViewController()
        let component = AppRootComponent(dependency: dependency, appRootViewController: viewController)
        let interactor = AppRootInteractor(presenter: viewController)
        
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        let loggedInBuilder = LoggedInBuilder(dependency: component)
        
        return AppRootRouter(interactor: interactor,
                             viewController: viewController,
                             loggedOutBuilder: loggedOutBuilder,
                             loggedInBuilder: loggedInBuilder)
    }
}
