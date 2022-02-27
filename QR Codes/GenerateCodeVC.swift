//
//  GenerateCodeVC.swift
//  QR Codes
//
//  Created by Eslam Nahel on 19/02/2022.
//

import UIKit
import CoreImage

class GenerateCodeVC: UIViewController {
    
    //MARK: - Components & Properties
    let appTitle                = AppLabel(fontSize: 22, weightFont: .bold)
    let QRCodePlaceholderImage  = UIImageView()
    let appTextField            = AppTextField()
    let generateButton          = AppButton(buttonStyle: .filled(), buttonImage: AppImages.qrCode!, buttonTitle: "Generate QR")
    
    private var buttonConstraint: NSLayoutConstraint!
    private var generatedString: String?
    private var generatedImage: UIImage?
    
    
    //MARK: - VC Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addAppTitle()
        addPlaceholderImage()
        addAppTextField()
        addGenerateButton()
        createDismissKeyboardGesture()
        addNotificationCenterToKeyboard()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.appTextField.textField.becomeFirstResponder()
        }
    }
    
    
    //MARK: - VC Methods
    private func generateQRCode() {
        guard var urlText = appTextField.textField.text, urlText != generatedString else {
            let shareVC = ShareAlertVC(url: generatedString!, qrImage: generatedImage!)
            shareVC.modalTransitionStyle = .crossDissolve
            shareVC.modalPresentationStyle = .overFullScreen
            present(shareVC, animated: true)
            return
        }
        
        generatedString = urlText
        
        if !urlText.contains("http") && !urlText.contains("www.") {
            urlText = "www." + urlText
        }
        
        guard urlText.isValidURL else {
            let alert = UIAlertController(title: "Invalid URL",
                                          message: "The URL you entered is not valid. Please check it again",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let data            = urlText.data(using: String.Encoding.ascii)
        guard let qrFilter  = CIFilter(name: "CIQRCodeGenerator") else { return }
        qrFilter.setValue(data, forKey: "inputMessage")
        
        let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
        if let qrImage = qrFilter.outputImage?.transformed(by: qrTransform) {
            guard let tintedQRImage = qrImage.tinted(using: AppColors.TealColor) else { return }
            generatedImage = UIImage(ciImage: tintedQRImage)
            let shareVC = ShareAlertVC(url: urlText, qrImage: UIImage(ciImage: tintedQRImage))
            shareVC.modalTransitionStyle = .crossDissolve
            shareVC.modalPresentationStyle = .overFullScreen
            present(shareVC, animated: true)
        }
    }
    
    
    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func addNotificationCenterToKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame          = keyboardValue.cgRectValue
        let keyboardViewEndFrame            = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.buttonConstraint.constant = -24
        } else {
            self.buttonConstraint.constant = -keyboardViewEndFrame.height + 10
        }
        self.view.layoutIfNeeded()
    }
    
    
    //MARK: - VC UI Setup Methods
    private func addAppTitle() {
        view.addSubview(appTitle)
        appTitle.text = "Enter a website URL to generate a unique QR code!"
        
        NSLayoutConstraint.activate([
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            appTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            appTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            appTitle.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    
    private func addPlaceholderImage() {
        view.addSubview(QRCodePlaceholderImage)
        QRCodePlaceholderImage.image = AppImages.qrCode?.withTintColor(AppColors.TealColor, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(.init(weight: .bold))
        
        QRCodePlaceholderImage.contentMode                  = .scaleAspectFill
        
        QRCodePlaceholderImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QRCodePlaceholderImage.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 58),
            QRCodePlaceholderImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            QRCodePlaceholderImage.widthAnchor.constraint(equalToConstant: 120),
            QRCodePlaceholderImage.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    private func addAppTextField() {
        view.addSubview(appTextField)
        appTextField.textField.delegate = self
        
        NSLayoutConstraint.activate([
            appTextField.topAnchor.constraint(equalTo: QRCodePlaceholderImage.bottomAnchor, constant: 46),
            appTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            appTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            appTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func addGenerateButton() {
        view.addSubview(generateButton)
        generateButton.configuration?.baseBackgroundColor = AppColors.TealColor.withAlphaComponent(0.4)
        generateButton.addAction(UIAction { _ in
            self.generateQRCode()
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            generateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generateButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        buttonConstraint = generateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        buttonConstraint.isActive = true
    }
}


//MARK: - VC Extensions
extension GenerateCodeVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text                    = textField.text ?? ""
        let currentString: NSString = (text) as NSString
        let newString: NSString     = currentString.replacingCharacters(in: range, with: string) as NSString
        
        if newString.length == 0 || newString.contains(" ") || !newString.isOnlyEnglish {
            generateButton.configuration?.baseBackgroundColor   = AppColors.TealColor.withAlphaComponent(0.4)
            generateButton.isUserInteractionEnabled             = false
        } else {
            generateButton.configuration?.baseBackgroundColor   = AppColors.TealColor
            generateButton.isUserInteractionEnabled             = true
        }
        
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        generateButton.configuration?.baseBackgroundColor   = AppColors.TealColor.withAlphaComponent(0.4)
        generateButton.isUserInteractionEnabled             = false
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        generateQRCode()
        return true
    }
}
