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
    
    // MARK: - With Results
    func testResultViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 224.0)
        // when
        let view = ResultView()
        let result = Result(
            totalPerPerson: 100.25,
            totalBill: 45.0,
            totalTip: 60)
        view.configure(result)
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testBillInputViewWithValues() {
        // given
        let size = CGSize(width: screenWidth, height: 224.0)
        // when
        let view = BillIntpuView()
        let textField = view.allSubviewsOf(type: UITextField.self).first
        textField?.text = "500"
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testTipInputViewWithValues10() {
        // given
        let size = CGSize(width: screenWidth, height: 224.0)
        // when
        let view = TipInputView()
        let button = view.allSubviewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testTipInputViewWithValues15() {
        // given
        let size = CGSize(width: screenWidth, height: 224.0)
        // when
        let view = TipInputView()
        let buttons = view.allSubviewsOf(type: UIButton.self)
        for button in buttons {
            if let titleText = button.titleLabel?.text, titleText == "15%" {
                button.sendActions(for: .touchUpInside)
            }
        }
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testTipInputViewWithValues20() {
        // given
        let size = CGSize(width: screenWidth, height: 224.0)
        // when
        let view = TipInputView()
        let buttons = view.allSubviewsOf(type: UIButton.self)
        for button in buttons {
            if let titleText = button.titleLabel?.text, titleText == "20%" {
                button.sendActions(for: .touchUpInside)
            }
        }
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testTipInputViewWithCustomValue() {
        // given
        let size = CGSize(width: screenWidth, height: 224.0)
        // when
        let view = TipInputView()
        let button = view.allSubviewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
    
    func testSplitInputViewWithSelection() {
        let size = CGSize(width: screenWidth, height: 56)
        // when
        let view = SplitInputView()
        let button = view.allSubviewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        // then
        assertSnapshots(of: view, as: [.image(size: size)], record: didUpdateSnapshot)
    }
}
