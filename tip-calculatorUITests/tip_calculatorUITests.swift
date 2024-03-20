//
//  tip_calculatorUITests.swift
//  tip-calculatorUITests
//
//  Created by Yani Buchkov on 15.03.24.
//

import XCTest

final class tip_calculatorUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var screen: CalculatorScreen {
        return CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewWithDefaultValues() {
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(screen.totalTipValueLabel.label, "$0")
    }
}
