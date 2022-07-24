//
//  SettingTableViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/23.
//

import UIKit

class SettingTableViewController: UITableViewController {

    // MARK: - Propertys
    var dataManager = SettingTableViewManager()
    
    var delegate: UserNameDelegate?
    
    
    
    // MARK: - LifyCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialUI()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    
    
    // MARK: - Methods
    func configureInitialUI() {
        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.SeSacLabelBorder]
        
        let barButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popButtonTapped))
        barButton.tintColor = .SeSacLabelBorder
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    
    @objc func popButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func renameButtonTapped() {
        let sb = UIStoryboard(name: "Rename", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "RenameViewController") as? RenameViewController else {
            self.view.makeToast("화면 전환 오류", duration: 1, position: .bottom)
            return
        }
        vc.delegate = self.delegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func changeTamagotchiButtonTapped() {
        let sb = UIStoryboard(name: "Selection", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SelectTamagotchiCollectionViewController") as? SelectTamagotchiCollectionViewController else {
            self.view.makeToast("화면 전환 오류", duration: 1, position: .bottom)
            return
        }
        vc.isInitialView = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func resetButtonTapped() {
        let alertController = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가용?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "아냐!", style: .default)
        let yesAction = UIAlertAction(title: "웅", style: .default) {_ in
            UserDefaultManager.shared.resetAllData()
            
            let sb = UIStoryboard(name: "Selection", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "SelectTamagotchiCollectionViewController") as? SelectTamagotchiCollectionViewController else {
                self.view.makeToast("화면 전환 오류", duration: 1, position: .bottom)
                return
            }
            
            let navi = UINavigationController(rootViewController: vc)
            
            self.changeRootViewController(to: navi)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        
        present(alertController, animated: true)
    }
}



// MARK: - TableView
extension SettingTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }

        cell.accessoryType = .disclosureIndicator
        cell.configureCellUI(data: dataManager.getCellInfo(at: indexPath.row), userName: indexPath.row == 0 ? delegate?.userName : nil)
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: renameButtonTapped()
        case 1: changeTamagotchiButtonTapped()
        case 2: resetButtonTapped()
        default: break
        }
    }
}
