//
//  SettingTableViewCell.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/23.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: SettingTableViewCell.self)

    // MARK: - Outlet
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!

    
    
    func configureCellUI(data: SettingCell, userName: String?) {
        if let userName = userName {
            userNameLabel.text = userName
            userNameLabel.setDefaultFont()
        }else {
            userNameLabel.text = ""
        }
        cellImageView.image = UIImage(systemName: data.image)
        cellTitleLabel.text = data.title
        
        cellImageView.tintColor = .seSacLabelBorder
        cellTitleLabel.setMediumFont()
        
        contentView.setBackgroundColor()
    }
}
