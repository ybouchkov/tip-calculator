//
//  SplitInputView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

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
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = buildButton(
            kIncrementText,
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner],
            radius: 8.0)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build("1", font: ThemeFont.bold(of: 20.0))
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
}
