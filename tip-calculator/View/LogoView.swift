//
//  LogoView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

class LogoView: UIView {
    // MARK: - IBOutlets & Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .icCalculatorBW1)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let firstText = "Mr"
        let differentFontText = "TIP"
        let joiningText = String.init(format: "%@ %@", firstText, differentFontText)
        let wholeText = NSMutableAttributedString(string: joiningText,
                                             attributes: [.font: ThemeFont.demiBold(of: 16.0)])
        let range = (joiningText as NSString).range(of: differentFontText)
        wholeText.addAttributes([.font: ThemeFont.bold(of: 24.0)], range: range)
        label.attributedText = wholeText
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            vLabelsStackView,
            UIView()
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.alignment = .center
        return stackView
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(
            "Calculator", font: ThemeFont.demiBold(of: 20.0), textAlignment: .left)
    }()
    
    private lazy var vLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = -4
        
        return stackView
    }()
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        layout()
        accessibilityIdentifier = ScreenIdentifier.LogoViewIdentifier.logoView.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Private:
    private func layout() {
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }
}
