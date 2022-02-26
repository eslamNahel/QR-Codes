//
//  AppTextField.swift
//  QR Codes
//
//  Created by Eslam Nahel on 26/02/2022.
//

import UIKit

class AppTextField: UIView {
    
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor             = .quaternarySystemFill
        layer.cornerRadius          = 8
        layer.cornerCurve           = .continuous
        layer.borderColor           = AppColors.TealColor.cgColor
        layer.borderWidth           = 0.5
        translatesAutoresizingMaskIntoConstraints = false
        configureTextField()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTextField() {
        textField.textColor                   = .black
        textField.tintColor                   = UIColor(red: 0.525, green: 0.523, blue: 0.523, alpha: 1)
        textField.textAlignment               = .left
        
        textField.font                        = .systemFont(ofSize: 17, weight: .regular)
        textField.adjustsFontSizeToFitWidth   = true
        textField.minimumFontSize             = 12
        
        
        textField.backgroundColor             = .clear
        textField.autocorrectionType          = .no
        textField.spellCheckingType           = .no
        textField.placeholder                 = "website.example"
        textField.returnKeyType               = .done
        textField.keyboardType                = .asciiCapable
        textField.clearButtonMode             = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        pinTextFieldToView()
    }
    
    
    private func pinTextFieldToView() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
