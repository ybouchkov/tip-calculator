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
        let logoViewPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private let audioPlayerService: AudioPlayerService
    
    // MARK: - Initialization
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
    // MARK: - Public
    // Binding
    func transform(_ input: Input) -> Output {
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
                let totalTip = getTipAmount(bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                let result = Result(
                    totalPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                return Just(result)
            }.eraseToAnyPublisher()

        let resetCalculatorPublisher = input
            .logoViewPublisher
            .handleEvents (receiveOutput: { [unowned self] in
                audioPlayerService.play()
            }).flatMap {
                return Just($0)
            }.eraseToAnyPublisher()
        
        return Output(updateViewPublisher: updateViewPublisher,
                      resetCalculatorPublisher: resetCalculatorPublisher)
    }
    
    private func getTipAmount(_ bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}
