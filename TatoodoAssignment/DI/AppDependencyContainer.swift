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

            container.register(PostsRemoteAPI.self) { _ -> PostsRemoteAPI in
                TTDPostsRemoteAPI(tattooRouter: APIRouter<PostsEndpoint>(),
                                  responseHandler: DefaultAPIResponseHandler())
            }
            
            container.register(PostsRepository.self) { resolver -> PostsRepository in
                TTDPostsRepository(tattoosRemoteAPI: resolver.resolve(PostsRemoteAPI.self).required())
            }.inObjectScope(.weak)
            
            container.register(PostsListControllerViewModeling.self) { resolver -> PostsListControllerViewModeling in
                PostsListControllerViewModel(dataProvider: PostsDataProvider(repository: resolver.resolve(PostsRepository.self).required()))
            }
            
            container.register(PostsListViewController.self) { resolver -> PostsListViewController in
                let vc: PostsListViewController = UIStoryboard(.tattoo).instantiateViewController()
                vc.navigationItem.title = "Posts"
                vc.viewModel = resolver.resolve(PostsListControllerViewModeling.self).required()
                return vc
            }
            
            container.register(TattooCoordinator.self) { (resolver, router: RouterType) -> TattooCoordinator in
                let postListVCFactory: () -> PostsListViewController = {
                    resolver.resolve(PostsListViewController.self).required()
                }
                return TattooCoordinator(router: router, postsListVCFactory: postListVCFactory)
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
