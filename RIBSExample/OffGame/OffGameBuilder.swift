//
//  OffGameBuilder.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/17.
//

import ModernRIBs

protocol OffGameDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
}

final class OffGameComponent: Component<OffGameDependency> {
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }
}

// MARK: - Builder

protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener) -> OffGameRouting
}

final class OffGameBuilder: Builder<OffGameDependency>, OffGameBuildable {

    override init(dependency: OffGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OffGameListener) -> OffGameRouting {
        let component = OffGameComponent(dependency: dependency)
        let viewController = OffGameViewController(
            player1Name: component.player1Name,
            player2Name: component.player2Name
        )
        
        let interactor = OffGameInteractor(presenter: viewController)
        interactor.listener = listener
        return OffGameRouter(interactor: interactor, viewController: viewController)
    }
}
