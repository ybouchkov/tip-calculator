//
//  ScreenIdentifier.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 20.03.24.
//

import Foundation

enum ScreenIdentifier {
    // MARK: - LogoView Identifiers
    enum LogoViewIdentifier: String {
        case logoView
    }
    
    // MARK: - Result View Identifiers
    enum ResultViewIdentifier: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    // MARK: - Bill View Identifiers
    enum BillViewIdentifier: String {
        case textFieldIdentifier
    }

    // MARK: - TipView Identifiers
    enum TipViewIdentifier: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipTextField
    }
    
    // MARK: - Split View Idenfifiers
    enum SplitViewIdentifier: String {
        case decrementButton
        case incrementButton
        case quantityLabel
    }
}
