//
//  UILabel+Extension.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit


extension UILabel {
    
    func setDefaultFont() {
        self.font = .systemFont(ofSize: 13, weight: .medium)
        self.textColor = .seSacLabelBorder
    }
    
    func setMediumFont() {
        self.font = .systemFont(ofSize: 14, weight: .medium)
        self.textColor = .seSacLabelBorder
    }
    
    func setBoldFont() {
        self.font = .systemFont(ofSize: 15, weight: .bold)
        self.textColor = .seSacLabelBorder
    }
    
    func setCustomFont(size: FontSize) {
        self.font = UIFont.setCustomFont(size: size)
        self.textColor = .seSacLabelBorder
    }
    
    func setBorder() {
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.seSacLabelBorder.cgColor
        self.layer.cornerRadius = self.frame.height / 8
    }
}
