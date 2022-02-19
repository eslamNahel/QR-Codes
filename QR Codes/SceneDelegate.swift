//
//  SceneDelegate.swift
//  QR Codes
//
//  Created by Eslam Nahel on 19/02/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.rootViewController = GenerateCodeVC()
        window?.makeKeyAndVisible()
    }

    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

