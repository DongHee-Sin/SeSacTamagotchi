//
//  SelectTamagotchiCollectionViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

class SelectTamagotchiCollectionViewController: UICollectionViewController {
    
    var dataManager = TamagotchiCollectionViewManager()
    
    
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
        return dataManager.count >= 20 ? dataManager.count : 20
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectTamagotchiCollectionViewCell", for: indexPath) as? SelectTamagotchiCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellUI(data: dataManager.getTamagotchiCellInfo(at: indexPath.row))
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < dataManager.count else { return }
        
        let sb = UIStoryboard(name: "PopUp", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else { return }
        
        vc.tamagotchiInfo = dataManager.getTamagotchiCellInfo(at: indexPath.row)
        vc.modalPresentationStyle = .overFullScreen
        
        present(vc, animated: true)
    }
    
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 20
        let itemWidth: CGFloat = UIScreen.main.bounds.width - (spacing * 4)
        let itemHeight: CGFloat = itemWidth * 1.3
        
        layout.itemSize = CGSize(width: itemWidth / 3, height: itemHeight / 3)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
}
