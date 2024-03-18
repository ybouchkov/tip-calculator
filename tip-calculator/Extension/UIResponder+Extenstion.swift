//
//  UIResponder+Extenstion.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 18.03.24.
//

import UIKit

extension UIResponder {
    var parentController: UIViewController? {
        return next as? UIViewController ?? next?.parentController
    }
}
