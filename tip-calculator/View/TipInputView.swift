//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit
import CombineCocoa
import Combine

class TipInputView: UIView {
    // MARK: - IBOutlets & Properties
    private let kTopTitleText = "Choose"
    private let kBottomTitleText = "your tip"
    private let kCustomButtonText = "Custom tips"
    private lazy var headerView: HeaderView = {
        return HeaderView(kTopTitleText, subTitle: kBottomTitleText)
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        // transform the tap event into other publisher
        button.tapPublisher.flatMap({
            Just(Tip.tenPercent) // value from Tip
        })
        .assign(to: \.value , on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        // transform the tap event into other publisher
        button.tapPublisher.flatMap {
            Just(Tip.fifteenPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()

    private lazy var twentyPercentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        // transform the tap event into other publisher
        button.tapPublisher.flatMap {
            Just(Tip.twentyPercent)
        }
        .assign(to: \.value, on: tipSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = ThemeFont.bold(of: 20.0)
        button.setTitle(kCustomButtonText, for: .normal)
        button.tintColor = .white
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(8.0)
        return button
    }()
    
    private lazy var hButtonStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
            tenPercentTipButton,
            fifteenPercentTipButton,
            twentyPercentTipButton,
       ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16.0
        return stackView
    }()
    
    private lazy var verticalButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hButtonStackView,
            customTipButton,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none) // value
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Private:
    private func layout() {
        [headerView, verticalButtonStackView].forEach(addSubview(_:))
        
        verticalButtonStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(verticalButtonStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(hButtonStackView.snp.centerY)
        }
    }
    
    // TipButton builder
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: 	.custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [.font: ThemeFont.bold(of: 20.0), .foregroundColor: UIColor.white])
        text.addAttributes([
            .font: ThemeFont.demiBold(of: 14.0)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
