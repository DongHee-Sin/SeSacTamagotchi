//
//  SelectTamagotchiCollectionViewCell.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

class SelectTamagotchiCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    // MARK: - Method
    func configureCellUI(data: TamagotchiCellInfo) {
        self.contentView.backgroundColor = .SeSacBackground
        
        nameLabel.setBorder()
        nameLabel.setDefaultFont()
        
        tamagotchiImageView.image = UIImage(named: data.imageString)
        nameLabel.text = data.name
    }
}
