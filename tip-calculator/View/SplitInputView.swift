//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    // MARK: - IBOutlets & Properties
    private let kTopText = "Split"
    private let kBottomText = "the total"
    private let kDecrementText = "-"
    private let kIncrementText = "+"
    
    private lazy var headerView: HeaderView = {
        return HeaderView(kTopText, subTitle: kBottomText)
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(
            kDecrementText,
            corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner],
            radius: 8.0)
        button.accessibilityIdentifier = ScreenIdentifier.SplitViewIdentifier.decrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }
        .assign(to: \.value, on: splitSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(
            kIncrementText,
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner],
            radius: 8.0)
        button.accessibilityIdentifier = ScreenIdentifier.SplitViewIdentifier.incrementButton.rawValue
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value + 1)
        }
        .assign(to: \.value, on: splitSubject)
        .store(in: &cancellables)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build("1", font: ThemeFont.bold(of: 20.0))
        label.accessibilityIdentifier = ScreenIdentifier.SplitViewIdentifier.quantityLabel.rawValue
        label.backgroundColor = .white
        return label
    }()

    private lazy var stackView: UIStackView =  {
        let stackView = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    // Combine
    private var cancellables = Set<AnyCancellable>()
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    
    // MARK: - Public
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func resetView() {
        splitSubject.send(1)
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
        [headerView, stackView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(stackView.snp.centerY)
            make.trailing.equalTo(stackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [decrementButton, incrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
    }
    
    // builder
    private func buildButton(_ title: String, corners: CACornerMask, radius: CGFloat) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = ThemeFont.bold(of: 20.0)
        button.backgroundColor = ThemeColor.primary
        button.addRoundedCorners(corners, radius: 8.0)
        return button
    }
    
    private func observe() {
        splitSubject.sink { [unowned self] value in
            quantityLabel.text = value.stringValue
        }
        .store(in: &cancellables)
    }
}
    
