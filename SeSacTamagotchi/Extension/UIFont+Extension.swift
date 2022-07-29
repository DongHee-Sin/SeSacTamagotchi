//
//  UIFont+Extension.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/29.
//

import UIKit

enum FontSize: CGFloat {
    case s = 13
    case m = 14
    case l = 15
}

extension UIFont {
    
    static func setCustomFont(size: FontSize) -> UIFont {
        return UIFont(name: "HBIOS-SYS", size: size.rawValue) ?? UIFont()
    }
    
}
