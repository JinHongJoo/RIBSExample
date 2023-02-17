//
//  AppComponent.swift
//  RIBSExample
//
//  Created by 주진홍 on 2023/02/16.
//

import ModernRIBs

final class AppComponent: Component<EmptyComponent>, AppRootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
