//
//  RenameViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/23.
//

import UIKit

class RenameViewController: UIViewController {

    // MARK: - Propertys
    var delegate: UserNameDelegate?
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var renameTextField: UITextField!
    @IBOutlet weak var lineView: UIView!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialUI()
    }

    
    
    // MARK: - Methdos
    func configureInitialUI() {
        renameTextField.placeholder = "대장님 이름을 알려주세요!"
        renameTextField.text = delegate?.userName
        renameTextField.borderStyle = .none
        renameTextField.textColor = .SeSacLabelBorder
        renameTextField.font = .systemFont(ofSize: 15)
        
        lineView.backgroundColor = .SeSacLabelBorder
        
        setNavigationBar()
    }
    
    
    func setNavigationBar() {
        self.navigationItem.title = "대장님 이름 정하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.SeSacLabelBorder]
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popButtonTapped))
        let rightBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        leftBarButton.tintColor = .SeSacLabelBorder
        rightBarButton.tintColor = .SeSacLabelBorder
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    
    @objc func popButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func saveButtonTapped() {
        if renameTextField.text != "" {
            delegate?.changeUserName(to: renameTextField.text!)
            popButtonTapped()
        }else {
            let alertController = UIAlertController(title: "바꿀 이름을 알려주세요!", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "넹", style: .default)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
}
