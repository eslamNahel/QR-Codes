//
//  AppButton.swift
//  QR Codes
//
//  Created by Eslam Nahel on 26/02/2022.
//

import UIKit

class AppButton: UIButton {
    
    private var buttonTitle: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    init(buttonStyle: UIButton.Configuration, buttonImage: UIImage, buttonTitle: String) {
        super.init(frame: .zero)
        self.buttonTitle        = buttonTitle
        configuration           = buttonStyle
        let boldLargeConfig     = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .medium)
        configuration?.image    = buttonImage.applyingSymbolConfiguration(boldLargeConfig)
        configuration?.baseForegroundColor = buttonStyle == .tinted() ? AppColors.TealColor : .white
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configuration?.baseBackgroundColor  = AppColors.TealColor
        configuration?.imagePadding         = 10
        
        var container                       = AttributeContainer()
        container.font                      = .systemFont(ofSize: 20, weight: .medium)
        configuration?.attributedTitle      = AttributedString(buttonTitle, attributes:  container)
        
        configuration?.cornerStyle          = .large

        translatesAutoresizingMaskIntoConstraints = false
    }
}
