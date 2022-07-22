//
//  SelectTamagotchiCollectionViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

class SelectTamagotchiCollectionViewController: UICollectionViewController {
    
    var dataManager: TamagochiDataManager!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialUI()
    }

    
    
    // MARK: - Methods
    func configureInitialUI() {
        self.collectionView.backgroundColor = .SeSacBackground
        
        collectionView.collectionViewLayout = configureCollectionViewLayout()
    }
}



// MARK: - CollectionView
extension SelectTamagotchiCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectTamagotchiCollectionViewCell", for: indexPath) as? SelectTamagotchiCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 16
        let itemWidth: CGFloat = UIScreen.main.bounds.width - (spacing * 4)
        let itemHeight: CGFloat = itemWidth * 1.2
        
        layout.itemSize = CGSize(width: itemWidth / 3, height: itemHeight / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        return layout
    }
}
