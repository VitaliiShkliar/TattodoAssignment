//
//  TattooDIContainer.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 18.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import Swinject
import UIKit.UIViewController

class TattooDIContainer {
    private let container: Container
    
    init(parentContainer: Container) {
        container = Container(parent: parentContainer) { container in
            // MARK: Posts list
            container.register(PostsListControllerViewModeling.self) { resolver -> PostsListControllerViewModeling in
                PostsListControllerViewModel(dataProvider: PostsDataProvider(repository: resolver.resolve(PostsRepository.self).required()))
            }
            
            container.register(PostsListViewController.self) { resolver -> PostsListViewController in
                let vc: PostsListViewController = UIStoryboard(.tattoo).instantiateViewController()
                vc.navigationItem.title = "Posts"
                vc.viewModel = resolver.resolve(PostsListControllerViewModeling.self).required()
                return vc
            }
            
            // MARK: Post Details
            container.register(PostDetailsControllerViewModeling.self) { (resolver, postListModel: PostListModel) -> PostDetailsControllerViewModeling in
                PostDetailsControllerViewModel(postsRepo: resolver.resolve(PostsRepository.self).required(), postModel: postListModel)
            }
            
            container.register(PostDetailsViewController.self) { (resolver, postListModel: PostListModel) -> PostDetailsViewController in
                let vc: PostDetailsViewController = UIStoryboard(.tattoo).instantiateViewController()
                vc.viewModel = resolver.resolve(PostDetailsControllerViewModeling.self, argument: postListModel).required()
                return vc
            }
            
            // MARK: Coordinator
            container.register(TattooCoordinator.self) { (resolver, router: RouterType) -> TattooCoordinator in
                let postListVCFactory: () -> PostsListViewController = {
                    resolver.resolve(PostsListViewController.self).required()
                }
                let postDetailsVCFactory: (PostListModel) -> PostDetailsViewController = { postListModel in
                    resolver.resolve(PostDetailsViewController.self, argument: postListModel).required()
                }
                return TattooCoordinator(router: router,
                                         postsListVCFactory: postListVCFactory,
                                         postDetailsVCFactory: postDetailsVCFactory)
            }.inObjectScope(.weak)
        }
    }
    
    func makeTattooCoordinator(router: RouterType) -> TattooCoordinator {
        container.resolve(TattooCoordinator.self, argument: router).required()
    }
    
    func makePostsListControllerViewModel() -> PostsListControllerViewModeling {
        container.resolve(PostsListControllerViewModeling.self).required()
    }
    
    func makePostDetailsControllerViewModel(postListModel: PostListModel) -> PostDetailsControllerViewModeling {
        container.resolve(PostDetailsControllerViewModeling.self, argument: postListModel).required()
    }
}
