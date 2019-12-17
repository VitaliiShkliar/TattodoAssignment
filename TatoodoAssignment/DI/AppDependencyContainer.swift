//
//  DependencyContainer.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit
import Swinject

class AppDependencyContainer {
    
    private lazy var appDIContainer: Container = {
        Container { container in
            container.register(TattooCoordinator.self) { (resolver, router: RouterType) -> TattooCoordinator in
                TattooCoordinator(router: router)
            }.inObjectScope(.weak)
            
            container.register(AppCoordinator.self) { resolver -> AppCoordinator in
                let rootVC = UIViewController()
                let navigationVC = UINavigationController(rootViewController: rootVC)
                navigationVC.navigationBar.isTranslucent = true
                let tattooCoordinatorFactory: (RouterType) -> TattooCoordinator = { router in
                    resolver.resolve(TattooCoordinator.self, argument: router).required()
                }
                let router = Router(navigationController: navigationVC)
                return AppCoordinator(router: router,
                                      tattooCoordinatorFacroty: tattooCoordinatorFactory)
            }.inObjectScope(.weak)
        }
    }()
    
    func makeAppCoordinator() -> AppCoordinator { appDIContainer.resolve(AppCoordinator.self).required(error: "Failed to create the AppCoordinator") }
}
