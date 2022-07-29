//
//  PopUpViewController.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit


class PopUpViewController: UIViewController {

    // MARK: - Propertys
    var tamagotchiInfo: TamagotchiCellInfo?
    
    var viewStatus: ViewStatus?
    
    
    
    // MARK: - Outlet
    @IBOutlet weak var popUpBackgroundView: UIView!
    
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tamagotchiDescriptionLabel: UILabel!
    
    @IBOutlet var lineViews: [UIView]!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialUI()
    }

    
    
    // MARK: - Methods
    func configureInitialUI() {
        if let tamaInfo = tamagotchiInfo {
            tamagotchiImageView.image = UIImage(named: tamaInfo.imageString)
            
            nameLabel.text = tamaInfo.type.description
            nameLabel.setDefaultFont()
            nameLabel.setBorder()
            
            tamagotchiDescriptionLabel.text = tamaInfo.description
            tamagotchiDescriptionLabel.numberOfLines = 0
            tamagotchiDescriptionLabel.setDefaultFont()
            tamagotchiDescriptionLabel.textAlignment = .center
            
            view.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.4)
        }

        popUpBackgroundView.clipsToBounds = true
        popUpBackgroundView.layer.cornerRadius = popUpBackgroundView.frame.height / 20
        popUpBackgroundView.setBackgroundColor()
        
        lineViews.forEach { $0.setLineColor() }
        
        setButtonStyle()
        
        switch viewStatus {
        case .initialView: startButton.setTitle("시작하기", for: .normal)
        case .changeView: startButton.setTitle("변경하기", for: .normal)
        default: break
        }
    }
    
    
    func setButtonStyle() {
        cancelButton.backgroundColor = .seSacDeepBackground
        cancelButton.tintColor = .seSacLabelBorder
        startButton.tintColor = .seSacLabelBorder
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            self.view.makeToast("화면 전환 오류", duration: 1, position: .bottom)
            return
        }

        if let type = tamagotchiInfo?.type {
            vc.tamagotchiManager.changeType(to: type)
        }
        
        let navi = UINavigationController(rootViewController: vc)
        
        changeRootViewController(to: navi)
    }
}
