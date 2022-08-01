//
//  SelectTamagotchiCollectionViewCell.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

class SelectTamagotchiCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: SelectTamagotchiCollectionViewCell.self)
    
    // MARK: - Outlet
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    // MARK: - Method
    func configureCellUI(data: TamagotchiCellInfo) {
        self.contentView.backgroundColor = .seSacBackground
        
        nameLabel.setBorder()
        nameLabel.setCustomFont(size: .s)
    
        tamagotchiImageView.image = UIImage(named: data.imageString)
        nameLabel.text = data.type.description
    }
}
