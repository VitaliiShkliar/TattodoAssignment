//
//  DependencyContainer.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit.UIViewController
import Swinject

class AppDependencyContainer {
    
    private lazy var appDIContainer: Container = {
        Container { container in
            container.register(PostsRemoteAPI.self) { _ -> PostsRemoteAPI in
                TTDPostsRemoteAPI(tattooRouter: APIRouter<PostsEndpoint>(),
                                  responseHandler: DefaultAPIResponseHandler())
            }
            
            container.register(PostsRepository.self) { resolver -> PostsRepository in
                #if TEST
                return FakePostsRepository()
                #else
                return TTDPostsRepository(tattoosRemoteAPI: resolver.resolve(PostsRemoteAPI.self).required())
                #endif
            }.inObjectScope(.weak)
            
            container.register(AppCoordinator.self) { _ -> AppCoordinator in
                let rootVC = UIViewController()
                let navigationVC = UINavigationController(rootViewController: rootVC)
                navigationVC.navigationBar.isTranslucent = true
                navigationVC.navigationBar.tintColor = UIColor.black
                let tattooDIContainer = TattooDIContainer(parentContainer: container)
                let router = Router(navigationController: navigationVC)
                return AppCoordinator(router: router,
                                      tattooCoordinatorFacroty: tattooDIContainer.makeTattooCoordinator(router:))
            }.inObjectScope(.weak)
        }
    }()
    
    func makeAppCoordinator() -> AppCoordinator { appDIContainer.resolve(AppCoordinator.self).required(error: "Failed to create the AppCoordinator") }
    
    func makePostsRepository() -> PostsRepository {
        appDIContainer.resolve(PostsRepository.self).required()
    }
}
