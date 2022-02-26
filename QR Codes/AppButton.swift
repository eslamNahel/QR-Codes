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
        configuration?.image    = buttonImage.applyingSymbolConfiguration(.init(weight: .bold))
        configuration?.baseForegroundColor = buttonStyle == .tinted() ? AppColors.TealColor : .white
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        configuration?.baseBackgroundColor  = AppColors.TealColor
        configuration?.imagePadding         = 6
        
        var container                       = AttributeContainer()
        container.font                      = UIFont.boldSystemFont(ofSize: 20)
        configuration?.attributedTitle      = AttributedString(buttonTitle, attributes:  container)
        
        configuration?.cornerStyle          = .large

        translatesAutoresizingMaskIntoConstraints = false
    }
}
