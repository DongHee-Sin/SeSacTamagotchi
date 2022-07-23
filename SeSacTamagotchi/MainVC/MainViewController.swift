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
    let tamagotchiManager = TamagotchiDataManager()
    
    
    
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
        
        self.navigationItem.title = "\(tamagotchiManager.getUserName())님의 다마고치"
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UserDefaultManager.shared.tamagotchi = tamagotchiManager.getTamagotchiInstance()
        UserDefaultManager.shared.userName = tamagotchiManager.getUserName()
    }
    
    
    
    // MARK: - Methods
    func configureInitialUI() {
        setTextField()
        setButton()
        setImage()
        setNavigationBar()
        setLabel()
        updateTamagotchiInfoLabel()
    }
    
    
    func setTextField() {
        [riceTextField, waterTextField].forEach {
            $0?.borderStyle = .none
            $0?.textAlignment = .center
            $0?.keyboardType = .numberPad
        }
        riceTextField.placeholder = "밥주세용"
        waterTextField.placeholder = "물주세용"
    }
    
    
    func setButton() {
        [giveRiceButton, giveWaterButton].forEach {
            guard let button = $0 else { return }
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.SeSacLabelBorder.cgColor
            button.layer.cornerRadius = button.frame.height / 10
            button.titleLabel?.textColor = .SeSacLabelBorder
        }
        giveRiceButton.setTitle("밥먹기", for: .normal)
        giveWaterButton.setTitle("물먹기", for: .normal)
    }
    
    
    func setNavigationBar() {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(settingButtonTapped))
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.SeSacLabelBorder]
        barButton.tintColor = .SeSacLabelBorder 
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    func setLabel() {
        speechBubbleLabel.text = tamagotchiManager.getSpeechBubbleText()
        speechBubbleLabel.setDefaultFont()
        speechBubbleLabel.numberOfLines = 0
        
        nameLabel.setBoldFont()
        nameLabel.setBorder()
        nameLabel.text = tamagotchiManager.getTamagotchiName()
        
        tamagotchiInfoLabel.setBoldFont()
    }
    
    
    func updateAfterGiving() {
        setImage()
        updateTamagotchiInfoLabel()
        speechBubbleLabel.text = tamagotchiManager.getSpeechBubbleText()
    }
    
    
    func updateTamagotchiInfoLabel() {
        tamagotchiInfoLabel.text = tamagotchiManager.getTamagotchiInfo()
    }
    
    
    func setImage() {
        tamagotchiImage.image = tamagotchiManager.getImage()
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
        let sb = UIStoryboard(name: "Setting", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SettingTableViewController") as? SettingTableViewController else {
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
        return tamagotchiManager.getUserName()
    }
    
    func changeUserName(to newName: String) {
        tamagotchiManager.changeUserName(to: newName)
    }
    
}
