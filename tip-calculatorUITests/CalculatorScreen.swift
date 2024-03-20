//
//  CalculatorScreen.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 20.03.24.
//

import XCTest

class CalculatorScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication!) {
        self.app = app
    }
    
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultViewIdentifier.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultViewIdentifier.totalBillValueLabel.rawValue]
    }

    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultViewIdentifier.totalTipValueLabel.rawValue]
    }
}
