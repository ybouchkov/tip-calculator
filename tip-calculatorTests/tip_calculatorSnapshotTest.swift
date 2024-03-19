//
//  tip_calculatorSnapshotTest.swift
//  tip-calculatorTests
//
//  Created by Yani Buchkov on 19.03.24.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator

final class tip_calculatorSnapshotTest: XCTestCase {
    // MARK: - Properties
    // screenWidth - the selected simulator screen width
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    private var didUpdateSnapshot: Bool = false

    func testLogoView() {
        // given
        let size = CGSize(width: screenWidth, height: 48.0)
        // when
        let view = LogoView()
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testResultView() {
        // given
        let size = CGSize(width: screenWidth, height: 224.0)
        // when
        let view = ResultView()
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testBillView() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        // when
        let view = BillIntpuView()
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testTipInputView() {
        // given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        // when
        let view = TipInputView()
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testSplitView() {
        // given
        let size = CGSize(width: screenWidth, height: 56)
        // when
        let view = SplitInputView()
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
}
