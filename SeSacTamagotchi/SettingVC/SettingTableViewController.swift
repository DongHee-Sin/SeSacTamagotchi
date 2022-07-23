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
    
    
    // MARK: - View Did Load
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
        case 0:
            let sb = UIStoryboard(name: "Rename", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "RenameViewController") as? RenameViewController else {
                return
            }
            vc.delegate = self.delegate
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let sb = UIStoryboard(name: "Selection", bundle: nil)
            guard let vc = sb.instantiateViewController(withIdentifier: "SelectTamagotchiCollectionViewController") as? SelectTamagotchiCollectionViewController else {
                return
            }
            vc.isInitialView = false
            self.navigationController?.pushViewController(vc, animated: true)
        case 2: break    // 데이터 초기화
        default: break
        }
    }
}
