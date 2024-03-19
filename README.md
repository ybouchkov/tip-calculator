# tip-calculator
iOS &amp; Swift - MVVM, Combine, SnapKit, Snapshot/UI/Unit Testing

<img src="https://github.com/ybouchkov/tip-calculator/assets/31844517/6cc7fa0f-b969-4f37-ab81-c542d623fa3f" width="450" height="1000">

<H2>Snapshots Tests</H2>
<table>
  <tr>
    <td> <img src="https://github.com/ybouchkov/tip-calculator/assets/31844517/40e16795-4d52-4f87-8835-ba6e667227d7" width="350" height="56"></td>
  </tr> 
  <tr>
    <td> <img src="https://github.com/ybouchkov/tip-calculator/assets/31844517/1a5a63d3-3ea5-4139-aab4-1b69d8658b9c" width="350" height="224"></td>
  </tr> 
  <tr>
    <td> <img src="https://github.com/ybouchkov/tip-calculator/assets/31844517/13ae8617-afbb-4cd5-9eec-a34d0d0d9ca6" width="350" height="56"></td>
  </tr> 
  <tr>
    <td> <img src="https://github.com/ybouchkov/tip-calculator/assets/31844517/bdc71d30-bf4d-4b21-ae8f-17e090e87580" width="350" height="150"></td>
  </tr> 
  <tr>
    <td> <img src="https://github.com/ybouchkov/tip-calculator/assets/31844517/50ac9bcf-a6a6-46ee-9182-b559ffe2e519" width="350" height="56"></td>
  </tr> 
</table>

<H2>Unit Tests</H2>

```swift
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
```
