//
//  AmountView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

class AmountView: UIView {
    
    private let title: String
    private let textAlignment: NSTextAlignment
    private let amountLabelIdentifier: String
    
    // MARK: - IBOUtlets & Properties
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            title,
            font: ThemeFont.regular(of: 18.0),
            textColor: ThemeColor.text,
            textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: ThemeFont.bold(of: 24.0)
            ])
        text.addAttributes([
            .font: ThemeFont.bold(of: 16)
        ], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        stackView.axis = .vertical
        return stackView
    }()
    // MARK: - Initialization
    init(_ title: String, alignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.title = title
        self.textAlignment = alignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private:
    private func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func getMutableAttributedText(_ amount: Double) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(
            string: amount.currencyFormatted,
            attributes: [
                .font: ThemeFont.bold(of: 24)
            ])
        text.addAttributes(
            [.font: ThemeFont.bold(of: 16)],
            range: NSMakeRange(0, 1))
        return text
    }
    
    // MARK: - Public
    func configure(_ amount: Double) {
        amountLabel.attributedText = getMutableAttributedText(amount)
    }
}

