//
//  ShareAlertVC.swift
//  QR Codes
//
//  Created by Eslam Nahel on 27/02/2022.
//

import UIKit

class ShareAlertVC: UIViewController {
    
    let cornerRadiusView    = UIView()
    let contentView         = UIView()
    let viewTitle           = AppLabel(fontSize: 22, weightFont: .bold)
    let dismissButton       = AppButton(buttonStyle: .tinted(), buttonImage: UIImage(systemName: "x.circle")!, buttonTitle: "")
    let generatedQRImage    = UIImageView()
    let qrCodeURL           = AppLabel(fontSize: 17, weightFont: .semibold)
    let shareButton         = AppButton(buttonStyle: .tinted(), buttonImage: UIImage(systemName: "square.and.arrow.up")!, buttonTitle: "Share")
    
    var image: UIImage!
    private var urlString: String!
    
    
    init(url: String, qrImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.urlString = url
        self.image = qrImage
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.902, green: 0.918, blue: 0.933, alpha: 0.8)
        addContentView()
        addViewTitle()
        addDismissButton()
        addQRCodeImage()
        addQRLabel()
        addShareButton()
    }
    
    
    private func shareQR() {
        let renderer = UIGraphicsImageRenderer(size: self.cornerRadiusView.bounds.size)
        let imageRen = renderer.image { ctx in
            self.cornerRadiusView.drawHierarchy(in: self.cornerRadiusView.bounds, afterScreenUpdates: true)
        }
//            if let jpgImage = imageRen.jpegData(compressionQuality: 0.8) {
//                let vc = UIActivityViewController(activityItems: [jpgImage], applicationActivities: nil)
//                vc.popoverPresentationController?.sourceView = self.view
//                self.present(vc, animated: true)
//            }
        if let jpgImage = self.image.jpegData(compressionQuality: 0.8) {
            let vc = UIActivityViewController(activityItems: [jpgImage], applicationActivities: nil)
            vc.popoverPresentationController?.sourceView = self.view
            vc.completionWithItemsHandler = { (activityType, completed: Bool, returnedItems:[Any]?, error: Error?) in
                if completed {
                   
                }
             }
            self.present(vc, animated: true)
        }
    }
    
    
    private func addShareButton() {
        cornerRadiusView.addSubview(shareButton)
        shareButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.shareQR()
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            shareButton.centerXAnchor.constraint(equalTo: cornerRadiusView.centerXAnchor),
            shareButton.widthAnchor.constraint(equalTo: cornerRadiusView.widthAnchor, constant: -48),
            shareButton.heightAnchor.constraint(equalToConstant: 56),
            shareButton.bottomAnchor.constraint(equalTo: cornerRadiusView.bottomAnchor, constant: -32)
        ])
    }
    
    
    private func addQRLabel() {
        cornerRadiusView.addSubview(qrCodeURL)
        qrCodeURL.text = self.urlString
        
        NSLayoutConstraint.activate([
            qrCodeURL.centerXAnchor.constraint(equalTo: cornerRadiusView.centerXAnchor),
            qrCodeURL.topAnchor.constraint(equalTo: generatedQRImage.bottomAnchor, constant: 25),
            qrCodeURL.widthAnchor.constraint(equalTo: cornerRadiusView.widthAnchor, constant: -40),
            qrCodeURL.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view != cornerRadiusView {
            self.dismiss(animated: true)
        }
    }
    
    
    private func addQRCodeImage() {
        cornerRadiusView.addSubview(generatedQRImage)
        
        generatedQRImage.contentMode = .scaleAspectFill
        generatedQRImage.image = self.image
        
        generatedQRImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            generatedQRImage.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 30),
            generatedQRImage.centerXAnchor.constraint(equalTo: cornerRadiusView.centerXAnchor),
            generatedQRImage.widthAnchor.constraint(equalToConstant: 130),
            generatedQRImage.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    
    private func addViewTitle() {
        viewTitle.text = "Your Unique QR Code!"
        cornerRadiusView.addSubview(viewTitle)
        
        NSLayoutConstraint.activate([
            viewTitle.centerXAnchor.constraint(equalTo: cornerRadiusView.centerXAnchor),
            viewTitle.topAnchor.constraint(equalTo: cornerRadiusView.topAnchor, constant: 30),
            viewTitle.heightAnchor.constraint(equalToConstant: 35),
            viewTitle.widthAnchor.constraint(equalToConstant: 233)
        ])
    }
    
    
    private func addDismissButton() {
        cornerRadiusView.addSubview(dismissButton)
        dismissButton.configuration?.cornerStyle = .capsule
        let boldLargeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
        dismissButton.configuration?.image = UIImage(systemName: "x.circle")!.applyingSymbolConfiguration(boldLargeConfig)
        
        dismissButton.addAction(UIAction{ _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: cornerRadiusView.topAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: cornerRadiusView.trailingAnchor, constant: -16),
            dismissButton.widthAnchor.constraint(equalToConstant: 38),
            dismissButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    private func addContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .clear
        contentView.layer.backgroundColor = UIColor.clear.cgColor
        contentView.layer.shadowColor = UIColor(red: 0.145, green: 0.165, blue: 0.192, alpha: 0.2).cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 29
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
            contentView.heightAnchor.constraint(equalToConstant: 390)
        ])
        
        addCornerRadiusView()
    }
    
    
    private func addCornerRadiusView() {
        cornerRadiusView.translatesAutoresizingMaskIntoConstraints = false
        cornerRadiusView.layer.cornerRadius = 27
        cornerRadiusView.layer.cornerCurve = .continuous
        cornerRadiusView.layer.masksToBounds = true
        cornerRadiusView.backgroundColor = .white
        
        contentView.addSubview(cornerRadiusView)
        
        NSLayoutConstraint.activate([
            cornerRadiusView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cornerRadiusView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cornerRadiusView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cornerRadiusView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
