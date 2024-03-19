//
//  ResultView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

class ResultView: UIView {
    // MARK: - IBOutlets & Properties
    private let kTotalBillText = "Total bill"
    private let kTotalTipText = "Total tip"

    private let headerLabel: UILabel = {
        LabelFactory.build(
            "Total p/perosn",
            font: ThemeFont.demiBold(of: 18.0))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.3
        label.adjustsFontSizeToFitWidth = true
        let text = NSMutableAttributedString(string: "$0",
                                             attributes: [.font: ThemeFont.bold(of: 48.0)])
        text.addAttributes([
            .font: ThemeFont.bold(of: 24.0)], range: NSMakeRange(0, 1)) // the first symbol - $
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var totalBillView: AmountView = {
        return AmountView(kTotalBillText, alignment: .left)
    }()
    
    private lazy var totalTipView: AmountView = {
        return AmountView(kTotalTipText, alignment: .right)
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildSpacerView(0),
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            totalBillView,
            UIView(),
            totalTipView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
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
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(CGSize(width: 0, height: 3),
                  color: .black,
                  radius: 12.0,
                  opacity: 0.1)
    }
    
    private func buildSpacerView(_ heigh: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: heigh).isActive = true
        return view
    }
    
    private func getMutableAttributedString(_ result: Result) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(
            string: result.totalPerPerson.currencyFormatted,
            attributes: [
                .font: ThemeFont.bold(of: 48)
            ])
        text.addAttributes(
            [.font: ThemeFont.bold(of: 24)],
            range: NSMakeRange(0, 1))
        return text
    }
    
    // MARK: - Public
    func configure(_ result: Result) {
        amountPerPersonLabel.attributedText = getMutableAttributedString(result)
        totalBillView.configure(result.totalBill)
        totalTipView.configure(result.totalTip)
    }

}
