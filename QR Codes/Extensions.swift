//
//  Extensions.swift
//  QR Codes
//
//  Created by Eslam Nahel on 27/02/2022.
//

import UIKit

fileprivate var containerView: UIView!

//MARK: - UIViewController Extension
extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, actionTitle: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}


//MARK: - String Extension
extension String {
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}


//MARK: - NSString Extension
extension NSString {
    
    var isOnlyEnglish: Bool {
        let textAsString = self as String.SubSequence
        
        for chara in textAsString {
            if (!(chara >= "a" && chara <= "z")
                && !(chara >= "A" && chara <= "Z")
                && !(chara >= "0" && chara <= "9")
                && !(chara == "-" || chara == "." || chara == "/" || chara == ":")) {
                return false
            }
        }
        return true
    }
}


//MARK: - CIImage Extension 
extension CIImage {
    
    var transparent: CIImage? {
        return inverted?.blackTransparent
    }
    
    
    var inverted: CIImage? {
        guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else { return nil }
        
        invertedColorFilter.setValue(self, forKey: "inputImage")
        return invertedColorFilter.outputImage
    }
    
    
    var blackTransparent: CIImage? {
        guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        blackTransparentFilter.setValue(self, forKey: "inputImage")
        return blackTransparentFilter.outputImage
    }
    
    
    func tinted(using color: UIColor) -> CIImage? {
        guard let transparentQRImage = transparent,
              let filter = CIFilter(name: "CIMultiplyCompositing"),
              let colorFilter = CIFilter(name: "CIConstantColorGenerator") else { return nil }
        
        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)
        
        return filter.outputImage!
    }
}

