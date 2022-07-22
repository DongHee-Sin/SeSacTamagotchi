//
//  MainViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

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
    
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialUI()
    }
    
    
    
    
    // MARK: - Methods
    func configureInitialUI() {
        setTextField()
        setButton()
        setImage()
        setNavigationBar()
        setLabel()
    }
    
    
    func setTextField() {
        [riceTextField, waterTextField].forEach {
            $0?.borderStyle = .none
            $0?.textAlignment = .center
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
        self.navigationItem.title = "\(UserDefaultManager.shared.userName)님의 다마고치"
    }
    
    
    func setImage() {
        tamagotchiImage.image = tamagotchiManager.getImage()
    }
    
    
    func setLabel() {
        speechBubbleLabel.text = tamagotchiManager.getSpeechBubbleText()
        speechBubbleLabel.setDefaultFont()
    }
}
