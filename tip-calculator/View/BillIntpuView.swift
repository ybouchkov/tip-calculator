//
//  BillIntpuView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit
import CombineCocoa
import Combine

class BillIntpuView: UIView {
    // MARK: - IBOutlets & Properties
    private let headerView: HeaderView = {
        return HeaderView("Enter", subTitle: "your bill")
    }()

    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(12.0)
        return view
    }()

    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.build(
            "$",
            font: ThemeFont.bold(of: 24.0))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField =  {
        let txtFiled = UITextField()
        txtFiled.borderStyle = .none
        txtFiled.font = ThemeFont.demiBold(of: 28.0)
        txtFiled.keyboardType = .decimalPad
        txtFiled.setContentHuggingPriority(.defaultLow, for: .horizontal)
        txtFiled.tintColor = ThemeColor.text
        txtFiled.textColor = ThemeColor.text
        // Add toolbar
        let frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: 36.0)
        let toolBar = UIToolbar(frame: frame)
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonPressed))
        toolBar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil, action: nil),
            doneBtn
        ]
        toolBar.isUserInteractionEnabled = true
        txtFiled.inputAccessoryView = toolBar
        return txtFiled
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let billSubject: PassthroughSubject<Double, Never> = .init()
    
    var valuePublisher: AnyPublisher<Double, Never> {
        return billSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private:
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24) // padding
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)
        
        currencyDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
            
    @objc
    private func doneButtonPressed() {
        textField.endEditing(true)
    }
    
    // MARK: - Observe
    private func observe() {
        textField.textPublisher.sink { [unowned self] text in
            billSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellables)
    }
}
