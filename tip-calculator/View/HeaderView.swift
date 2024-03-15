//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

class HeaderView: UIView {
    // MARK: - Properties
    private let topTile: String
    private let bottomTitle: String
    
    // MARK: - Properties
    private lazy var topLabel: UILabel = {
        LabelFactory.build(
            topTile,
            font: ThemeFont.bold(of: 18.0))
    }()
    
    private lazy var bottomLabel: UILabel = {
        LabelFactory.build(
            bottomTitle,
            font: ThemeFont.regular(of: 16.0))
    }()

    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()
    // MARK: - Init
    init(_ title: String, subTitle: String) {
        self.topTile = title
        self.bottomTitle = subTitle
        super.init(frame: .zero)
        layout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func layout() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView)
        }
    }
    
    // MARK: - Public:
    func config(_ title: String, subTitle: String) {
        topLabel.text = title
        bottomLabel.text = subTitle
    }
}
