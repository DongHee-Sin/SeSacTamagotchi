//
//  TamagotchiDataManager.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

enum TamagochiType: Int, CustomStringConvertible {
    case sting, smail, twinkle, none
    
    var description: String {
        switch self {
        case .sting:  return "따끔따끔 다마고치"
        case .smail:  return "방실방실 다마고치"
        case .twinkle:  return "반짝반짝 다마고치"
        case .none: return "준비중이에요"
        }
    }
}


struct Tamagochi {
    var type: TamagochiType
    var rice: Int = 0
    var water: Int = 0
    var level: Int = 1
}


struct TamagochiDataManager {
    private var tamagochi: Tamagochi
    
    init(tamagochiType: TamagochiType) {
        self.tamagochi = Tamagochi(type: tamagochiType)
    }
    
    mutating func giveRice(count: Int) {
        guard count < 100 else {return}
        
        tamagochi.rice += count
    }
    
    mutating func giveWater(count: Int) {
        guard count < 50 else {return}
        
        tamagochi.water += count
    }
    
    mutating func changeType(to newType: TamagochiType) {
        tamagochi.type = newType
    }
    
    func getImage() -> UIImage {
        let typeNumber: Int = tamagochi.type.rawValue
        let level: Int = tamagochi.level > 9 ? 9 : tamagochi.level
        
        return UIImage(named: "\(typeNumber)-\(level)") ?? UIImage()
    }
}
