//
//  AppCoordinator.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator<DeepLink> {
    private let tattooCoordinatorFactory: (RouterType) -> TattooCoordinator
    
    init(router: RouterType, tattooCoordinatorFacroty: @escaping (RouterType) -> TattooCoordinator) {
        self.tattooCoordinatorFactory = tattooCoordinatorFacroty
        super.init(router: router)
    }
    
    override func start() {
        goToTatooFlow()
    }

}
// MARK: - Navigation
extension AppCoordinator {
    func goToTatooFlow() {
        let tattooCoordinator = tattooCoordinatorFactory(router)
        addChild(tattooCoordinator)
        tattooCoordinator.start()
    }
}
