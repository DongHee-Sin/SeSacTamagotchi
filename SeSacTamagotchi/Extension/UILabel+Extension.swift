//
//  UILabel+Extension.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit


extension UILabel {
    func addInset() {
        
    }
    
    func setDefaultFont() {
        self.font = .systemFont(ofSize: 13, weight: .medium)
        self.textColor = .SeSacLabelBorder
        self.textAlignment = .center
    }
    
    func setNavigationTitleFont() {
        self.font = .systemFont(ofSize: 15, weight: .bold)
        self.textColor = .SeSacLabelBorder
    }
    
    func setBorder() {
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.SeSacLabelBorder.cgColor
        self.layer.cornerRadius = self.frame.height / 8
    }
}
