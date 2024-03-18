//
//  CalculatorViewModel.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 18.03.24.
//

import Foundation
import Combine

class CalculatorViewModel {
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    // MARK: - Public
    // Binding
    func transform(_ input: Input) -> Output {
        let result = Result(
            totalPerPerson: 1000,
            totalBill: 500,
            totalTip: 200)
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
}
