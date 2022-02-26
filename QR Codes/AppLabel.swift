//
//  AppTitle.swift
//  QR Codes
//
//  Created by Eslam Nahel on 26/02/2022.
//

import UIKit

class AppLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(fontSize: CGFloat, weightFont: UIFont.Weight) {
        self.init(frame: .zero)
        self.font = .systemFont(ofSize: fontSize, weight: weightFont)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textColor                   = .black
        backgroundColor             = .clear
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.8
        lineBreakMode               = .byWordWrapping
        numberOfLines               = 0
        textAlignment               = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
