//
//  NavigationBar+Extension.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/29.
//

import UIKit

extension UINavigationBar {
    
    func setNavigationBarTitleFont() {
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.seSacLabelBorder,
            NSAttributedString.Key.font: UIFont.setCustomFont(size: .l)
        ]
        
        Self.appearance().titleTextAttributes = attrs
    }
    
}
