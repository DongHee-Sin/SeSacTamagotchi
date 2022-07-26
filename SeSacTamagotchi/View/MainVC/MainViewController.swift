//
//  MainViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

protocol PresentAlertDelegate {
    func presentAlert(message: String)
}



protocol UserNameDelegate {
    var userName: String {get}
    
    func changeUserName(to newName: String)
}



class MainViewController: UIViewController {

    // MARK: - Property
    let tamagotchiManager = TamagotchiDataManager.shared
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var speechBubbleLabel: UILabel!
    @IBOutlet weak var tamagotchiImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tamagotchiInfoLabel: UILabel!
    
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var waterTextField: UITextField!
    
    @IBOutlet var lineViews: [UIView]!
    
    @IBOutlet weak var giveRiceButton: UIButton!
    @IBOutlet weak var giveWaterButton: UIButton!
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureInitialUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "\(tamagotchiManager.userName)님의 다마고치"
        speechBubbleLabel.text = tamagotchiManager.getSpeechBubbleText()
    }
    
    
    
    // MARK: - Methods
    func configureInitialUI() {
        setTextField()
        setButton()
        setImage()
        setNavigationBar()
        setLabel()
        updateTamagotchiInfoLabel()
        
        view.setBackgroundColor()
        
        riceTextField.delegate = self
        waterTextField.delegate = self
    }
    
    
    func setTextField() {
        [riceTextField, waterTextField].forEach {
            guard let textField = $0 else { return }
            textField.borderStyle = .none
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
        }
        riceTextField.placeholder = "밥주세용"
        waterTextField.placeholder = "물주세용"
    }
    
    
    func setButton() {
        [giveRiceButton, giveWaterButton].forEach {
            guard let button = $0 else { return }
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.seSacLabelBorder.cgColor
            button.layer.cornerRadius = button.frame.height / 8
            button.tintColor = .seSacLabelBorder
            button.titleLabel?.font = .boldSystemFont(ofSize: 14
            )
        }
        
        giveRiceButton.setTitle("밥먹기", for: .normal)
        giveWaterButton.setTitle("물먹기", for: .normal)
        
        giveRiceButton.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        giveWaterButton.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
    }
    
    
    func setNavigationBar() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(settingButtonTapped))
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.seSacLabelBorder, NSAttributedString.Key.font: UIFont.setCustomFont(size: .l)]
        barButton.tintColor = .seSacLabelBorder
        self.navigationItem.rightBarButtonItem = barButton
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .seSacBackground
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    
    func setLabel() {
        speechBubbleLabel.text = tamagotchiManager.getSpeechBubbleText()
        speechBubbleLabel.setCustomFont(size: .s)
        speechBubbleLabel.numberOfLines = 0
        speechBubbleLabel.textAlignment = .center
        
        nameLabel.setCustomFont(size: .l)
        nameLabel.setBorder()
        nameLabel.text = tamagotchiManager.tamagotchiName
        nameLabel.backgroundColor = .seSacDeepBackground
        
        tamagotchiInfoLabel.setMediumFont()
    }
    
    
    func setImage() {
        tamagotchiImage.image = tamagotchiManager.getImage()
    }
    
    
    func updateAfterGiving() {
        setImage()
        updateTamagotchiInfoLabel()
        speechBubbleLabel.text = tamagotchiManager.getSpeechBubbleText()
    }
    
    
    func updateTamagotchiInfoLabel() {
        tamagotchiInfoLabel.text = tamagotchiManager.tamagotchiInfoString
    }
    
    
    @IBAction func giveRiceButtonTapped(_ sender: UIButton) {
        tamagotchiManager.giveRice(count: Int(riceTextField.text ?? "") ?? 1, delegate: self)
        updateAfterGiving()
    }
    
    
    @IBAction func giveWaterButtonTapped(_ sender: UIButton) {
        tamagotchiManager.giveWater(count: Int(waterTextField.text ?? "") ?? 1, delegate: self)
        updateAfterGiving()
    }
    
    
    @objc func settingButtonTapped() {
        let sb = UIStoryboard.setting
        guard let vc = sb.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as? SettingTableViewController else {
            self.view.makeToast("화면 전환 오류", duration: 1, position: .bottom)
            return
        }
        
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



extension MainViewController: PresentAlertDelegate {
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "넹", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
}



extension MainViewController: UserNameDelegate {
    var userName: String {
        return tamagotchiManager.userName
    }
    
    func changeUserName(to newName: String) {
        tamagotchiManager.changeUserName(to: newName)
    }
    
}



extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true
        }else {
            self.view.makeToast("숫자만 입력해주세요!", duration: 1, position: .center)
            return false
        }
    }
}
