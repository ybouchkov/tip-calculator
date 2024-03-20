//
//  CalculatorScreen.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 20.03.24.
//

import XCTest

// https://www.hackingwithswift.com/articles/148/xcode-ui-testing-cheat-sheet - cheat sheet for testing
class CalculatorScreen {
    
    private let app: XCUIApplication
    
    enum Tip {
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
    }
    
    init(app: XCUIApplication!) {
        self.app = app
    }
    
    // MARK: - LogoView
    var logoView: XCUIElement {
        return app.otherElements[ScreenIdentifier.LogoViewIdentifier.logoView.rawValue]
    }

    // MARK: - Result View
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultViewIdentifier.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultViewIdentifier.totalBillValueLabel.rawValue]
    }

    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultViewIdentifier.totalTipValueLabel.rawValue]
    }
    
    // MARK: - BillView
    var billTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.BillViewIdentifier.textFieldIdentifier.rawValue]
    }
    
    // MARK: - Tip View
    var tenPercentButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipViewIdentifier.tenPercentButton.rawValue]
    }

    var fifteenPercentButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipViewIdentifier.fifteenPercentButton.rawValue]
    }

    var twenntyPercentButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipViewIdentifier.twentyPercentButton.rawValue]
    }
        
    var customTipButton: XCUIElement {
        return app.buttons[ScreenIdentifier.TipViewIdentifier.customTipButton.rawValue]
    }
    
    var customTipTextField: XCUIElement {
        return app.textFields[ScreenIdentifier.TipViewIdentifier.customTipTextField.rawValue]
    }
    
    // MARK: - Split View
    var decrementButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitViewIdentifier.decrementButton.rawValue]
    }
    
    var incrementButton: XCUIElement {
        return app.buttons[ScreenIdentifier.SplitViewIdentifier.incrementButton.rawValue]
    }

    var quantityLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.SplitViewIdentifier.quantityLabel.rawValue]
    }
    
    // MARK: - Actions
    func enterBill(_ amount: Double) {
        billTextField.tap()
        billTextField.typeText("\(amount)\n")
    }
    
    func selectTip(_ tip: Tip) {
        switch tip {
        case .tenPercent:
            tenPercentButton.tap()
        case .fifteenPercent:
            twenntyPercentButton.tap()
        case .twentyPercent:
            twenntyPercentButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipButton.waitForExistence(timeout: 1.0))
            customTipTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectDecrementButton(numberOfTaps: Int) {
        decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func doubleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
}
