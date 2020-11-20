//
//  UIStoryboard+Extensions.swift
//  Books
//
//  Created by Admin on 13.11.2020.
//

import UIKit

extension UIStoryboard {
    static func instantiateViewControllerFromMain<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        let main = UIStoryboard(name: "Main", bundle: Bundle.init(for: T.self))
        return main.instantiateViewController(withIdentifier: identifier) as! T
    }
}
