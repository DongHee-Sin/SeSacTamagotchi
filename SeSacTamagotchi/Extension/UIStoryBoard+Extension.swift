//
//  UIStoryBoard+Extension.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/31.
//

import UIKit

extension UIStoryboard {
    
    static var selection: UIStoryboard { return UIStoryboard(name: "Selection", bundle: nil) }
    
    static var popUp: UIStoryboard { return UIStoryboard(name: "PopUp", bundle: nil) }
    
    static var main: UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }
    
    static var setting: UIStoryboard { return UIStoryboard(name: "Setting", bundle: nil) }
    
    static var rename: UIStoryboard { return UIStoryboard(name: "Rename", bundle: nil) }
    
}
