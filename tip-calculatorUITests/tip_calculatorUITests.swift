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
    
    func testRegularTip() {
        // User enters 100 BGN TIP
        screen.enterBill(100)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "100\u{00a0}BGN")
        XCTAssertEqual(screen.totalBillValueLabel.label, "100\u{00a0}BGN")
        XCTAssertEqual(screen.totalTipValueLabel.label, "0\u{00a0}BGN")
        
        // User select 10%
        screen.selectTip(.tenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "110\u{00a0}BGN")
        XCTAssertEqual(screen.totalBillValueLabel.label, "110\u{00a0}BGN")
        XCTAssertEqual(screen.totalTipValueLabel.label, "10\u{00a0}BGN")
        
        // User select 15%
        screen.selectTip(.fifteenPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "115\u{00a0}BGN")
        XCTAssertEqual(screen.totalBillValueLabel.label, "115\u{00a0}BGN")
        XCTAssertEqual(screen.totalTipValueLabel.label, "15\u{00a0}BGN")

        // User select 20%
        screen.selectTip(.twentyPercent)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "120\u{00a0}BGN")
        XCTAssertEqual(screen.totalBillValueLabel.label, "120\u{00a0}BGN")
        XCTAssertEqual(screen.totalTipValueLabel.label, "20\u{00a0}BGN")

        // User splits by 4
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "30\u{00a0}BGN")
        XCTAssertEqual(screen.totalBillValueLabel.label, "120\u{00a0}BGN")
        XCTAssertEqual(screen.totalTipValueLabel.label, "20\u{00a0}BGN")
        
        // User splits by 2
        screen.selectDecrementButton(numberOfTaps: 2)
        XCTAssertEqual(screen.totalAmountPerPersonValueLabel.label, "60\u{00a0}BGN")
        XCTAssertEqual(screen.totalBillValueLabel.label, "120\u{00a0}BGN")
        XCTAssertEqual(screen.totalTipValueLabel.label, "20\u{00a0}BGN")
    }
}
