//
//  ViewController.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit
import SnapKit
import Combine

class CalculatorViewController: UIViewController {
    // MARK: - IBOutlets & Properties
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillIntpuView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private let viewModel = CalculatorViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 36.0
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - CalculatorViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // perform layout - using snapKit ❤️
        layout()
        bind()
    }
    
    // MARK: - Private:
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }

        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
    
    private func bind() {
        
        let input = CalculatorViewModel.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: Just(5).eraseToAnyPublisher())
        
        let output = viewModel.transform(input)
        
        output.updateViewPublisher.sink { result in
            print(">>>> \(result)")
        }.store(in: &cancellables)
    }
}

