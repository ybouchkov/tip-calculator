//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

struct LabelFactory {
    static func build(_ text: String?, font: UIFont,
                      backgroundColor: UIColor = UIColor.clear,
                      textColor: UIColor = ThemeColor.text, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
