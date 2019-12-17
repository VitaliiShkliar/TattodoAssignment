//
//  TatooCoordinator.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit

class TattooCoordinator: Coordinator<DeepLink> {
    private let postsListVCFactory: () -> PostsListViewController
    
    private lazy var postsListVC: PostsListViewController = {
        let vc = self.postsListVCFactory()
        vc.delegate = self
        return vc
    }()
    
    init(router: RouterType,
         postsListVCFactory: @escaping () -> PostsListViewController) {
        self.postsListVCFactory = postsListVCFactory
        super.init(router: router)
    }
    
    override func start() {
        router.setRootModule(self, hideBar: false, animated: false)
    }
    
    override func toPresentable() -> UIViewController { postsListVC }
}

// MARK: Navigation
extension TattooCoordinator {
    func goToDetails(ofThe post: PostListModel) {
        
    }
}

extension TattooCoordinator: PostsListViewControllerDelegate {
    func didSelect(post: PostListModel) {
        goToDetails(ofThe: post)
    }
}
