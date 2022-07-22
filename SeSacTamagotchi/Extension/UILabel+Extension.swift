//
//  UILabel+Extension.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit


extension UILabel {
    func setDefaultFont() {
        self.font = .systemFont(ofSize: 13, weight: .regular)
        self.textColor = .SeSacLabelBorder
    }
    
    func setNavigationTitleFont() {
        self.font = .systemFont(ofSize: 15, weight: .medium)
        self.textColor = .SeSacLabelBorder
    }
}
