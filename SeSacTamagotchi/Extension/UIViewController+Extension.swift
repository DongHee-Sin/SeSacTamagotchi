//
//  UIViewController+Extension.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

@objc
protocol CommonSettings {
    static var identifier: String { get }
    
    @objc optional func configureInitialUI()
}



extension UIViewController: CommonSettings {
    
    static var identifier: String { String(describing: self) }
    
    func changeRootViewController(to rootVC: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = rootVC
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
