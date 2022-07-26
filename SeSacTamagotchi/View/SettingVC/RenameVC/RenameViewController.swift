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
        renameTextField.textColor = .seSacLabelBorder
        renameTextField.font = .systemFont(ofSize: 15)
        
        lineView.backgroundColor = .seSacLabelBorder
        
        setNavigationBar()
        
        view.setBackgroundColor()
    }
    
    
    func setNavigationBar() {
        self.navigationItem.title = "대장님 이름 정하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.seSacLabelBorder]
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popButtonTapped))
        let rightBarButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        leftBarButton.tintColor = .seSacLabelBorder
        rightBarButton.tintColor = .seSacLabelBorder
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    
    @objc func popButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func saveButtonTapped() {
        if let newName = renameTextField.text, 2...6 ~= newName.count {
            delegate?.changeUserName(to: newName)
            popButtonTapped()
        }else {
            let alertController = UIAlertController(title: "이름 규칙을 확인해주세요", message: "2~6글자 사이의 이름만 사용할 수 있습니다", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "넹", style: .default)
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
}
