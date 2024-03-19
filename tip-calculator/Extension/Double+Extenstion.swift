//
//  Double+Extenstion.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 19.03.24.
//

import Foundation

extension Double {
    var stringValue: String {
        String(self)
    }
    
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true : !isNormal ? false : self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
