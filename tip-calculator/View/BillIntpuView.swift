//
//  BillIntpuView.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 15.03.24.
//

import UIKit

class BillIntpuView: UIView {
    // MARK: - IBOutlets & Properties
    
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
        backgroundColor = .blue
    }
}
