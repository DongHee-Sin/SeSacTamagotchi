//
//  SelectTamagotchiCollectionViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit
import Toast

class SelectTamagotchiCollectionViewController: UICollectionViewController {
    
    // MARK: - Propertys
    var dataManager = TamagotchiCollectionViewManager()
    
    var isInitialView: Bool = true
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialUI()
    }

    
    
    // MARK: - Methods
    func configureInitialUI() {
        self.collectionView.backgroundColor = .SeSacBackground
        
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        
        self.navigationItem.title = isInitialView ? "다마고치 선택하기" : "다마고치 변경하기"
        if !isInitialView { self.navigationController?.navigationBar.tintColor = .SeSacLabelBorder }
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
        guard indexPath.row < dataManager.count else {
            self.view.makeToast("준비중입니다", duration: 1, position: .center)
            return
        }
        
        let sb = UIStoryboard(name: "PopUp", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else {
            self.view.makeToast("화면 전환 오류", duration: 1, position: .bottom)
            return
        }
        
        vc.tamagotchiInfo = dataManager.getTamagotchiCellInfo(at: indexPath.row)
        vc.modalPresentationStyle = .overFullScreen
        vc.isInitialView = self.isInitialView
        
        present(vc, animated: true)
    }
    
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 12
        let itemWidth: CGFloat = UIScreen.main.bounds.width - (spacing * 4) - 1
        let itemHeight: CGFloat = itemWidth * 1.2
        
        layout.itemSize = CGSize(width: itemWidth / 3, height: itemHeight / 3)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
}
