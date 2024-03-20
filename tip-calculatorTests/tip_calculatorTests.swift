//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Yani Buchkov on 15.03.24.
//

import XCTest
import Combine

@testable import tip_calculator

final class tip_calculatorTests: XCTestCase {
    // MARK: - Properties
    // sut -> system under test, the object that we are going to test is - viewModel
    private var sut: CalculatorViewModel!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    
    private var audioPlayerService: MockAudioPlayerService!
    
    // MARK: - Setup
    // Description: Every time the system is going to be tested, setUp method is called - we need to initialize out sut there
    override func setUp() {
        audioPlayerService = .init()
        logoViewTapSubject = .init()
        sut = .init(audioPlayerService: audioPlayerService)
        cancellables = .init()
        super.setUp()
    }
    
    // tearDown method is called every time when the test is going to finish
    override func tearDown() {
        super.setUp()
        sut = nil
        cancellables = nil
        audioPlayerService = nil
        logoViewTapSubject = nil
    }
    
    // The user is going to enter 100 BGN bill, there is no tip, split is going to be 1, total bill = 0, total tip = 0
    func testResultWithoutTipFor1Perosn() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split)
        // when
        let output = sut.transform(input)
        // then - assertion, means we want to test that out output is accurate
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorViewModel.Input {
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
    
    // testResultWithoutTipFor2Person
    func testResultWithoutTipFor2Person() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split)
        // when
        let output = sut.transform(input)
        // then - assertion, means we want to test that out output is accurate
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 50) // splitting bill among 2 person
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    // testResultWith10PercentTipFor2Person
    func testResultWith10PercentTipFor2Person() {
        // given
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split)
        // when
        let output = sut.transform(input)
        // then - assertion, means we want to test that out output is accurate
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 55.0) // splitting bill among 2 person
            XCTAssertEqual(result.totalBill, 110.0)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellables)
    }

    // testResultWithCustomPercentTipFor4Person
    func testResultWithCustomPercentTipFor4Person() {
        let bill: Double = 100.0
        let tip: Tip = .custom(value: 15)
        let split: Int = 4
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split)
        // when
        let output = sut.transform(input)
        // then - assertion, means we want to test that out output is accurate
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.totalPerPerson, 28.75) // splitting bill among 2 person
            XCTAssertEqual(result.totalBill, 115.0)
            XCTAssertEqual(result.totalTip, 15)
        }.store(in: &cancellables)
    }
    
    func testSoundPlayedAndCalculatorResetOnLogoViewTap() {
        // given
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayerService.expectation
        // then
        output.resetCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellables)
        
        // when
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
    }
}

class MockAudioPlayerService: AudioPlayerService {
    var expectation = XCTestExpectation(description: "playSound is called")
    
    func play() {
        expectation.fulfill()
    }
}
