//
//  UIStoryboard+Extension.swift
//  TatoodoAssignment
//
//  Created by Vitalii Shkliar on 17.12.2019.
//  Copyright © 2019 Vitalii Shkliar. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case tattoo
        var filename: String {
            return self.rawValue.capitalized
        }
    }
    
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.filename, bundle: Bundle.main)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
    
}
