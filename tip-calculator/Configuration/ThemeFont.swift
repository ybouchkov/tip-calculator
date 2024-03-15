//
//  ThemeFont.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

struct ThemeFont {
    // AvenirNext-Family
    private static let kFontNameRegular = "AvenirNext-Regular"
    private static let kFontNameBold = "AvenirNext-Bold"
    private static let kFontNameDemibold = "AvenirNext-DemiBold"
    
    static func regular(of size: CGFloat) -> UIFont {
        return UIFont(name: ThemeFont.kFontNameRegular, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(of size: CGFloat) -> UIFont {
        return UIFont(name: ThemeFont.kFontNameBold, size: size) ?? .systemFont(ofSize: size)
    }

    static func demiBold(of size: CGFloat) -> UIFont {
        return UIFont(name: ThemeFont.kFontNameDemibold, size: size) ?? .systemFont(ofSize: size)
    }
}
