//
//  TamagotchiDataManager.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit

enum TamagochiType: Int, CustomStringConvertible, Codable {
    case sting = 1, smail, twinkle, none
    
    var description: String {
        switch self {
        case .sting:  return "따끔따끔 다마고치"
        case .smail:  return "방실방실 다마고치"
        case .twinkle:  return "반짝반짝 다마고치"
        case .none: return "준비중이에요"
        }
    }
}



struct Tamagochi: Codable {
    var type: TamagochiType
    var rice: Int = 0
    var water: Int = 0
    var level: Int = 1
}



class TamagotchiDataManager {
    
    private var tamagochi: Tamagochi
    private var userName: String
    
    
    lazy var speechBubbleList: [String] = [
        "\(userName)님 커밋 푸시 하셨나요?",
        "복습 아직 안하셨다구요? 지금 잠이 오세요? \(userName)님???",
        "\(userName)님! 과제할 시간이네요!",
        "\(userName)님 잠은 죽어서 자는 것도 나쁘지 않을 것 같아요.",
        "전 아직 배고파요 \(userName)님 먹을걸 더 주세요",
        "테이블뷰컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요?",
        "\(userName)님, 야식 메뉴로는 어떤게 좋을까요?",
        "배불러요..!! 그만 먹이세요",
    ]
    
    
    init() {
        self.tamagochi = UserDefaultManager.shared.tamagotchi
        self.userName = UserDefaultManager.shared.userName
    }
    

    func giveRice(count: Int, delegate: PresentAlertDelegate) {
        guard count < 100 else {
            delegate.presentAlert(message: "100개 이상의 밥은 한 번에 먹을 수 없어요!")
            return
        }
        updateLevel()
        tamagochi.rice += count
    }
    

    func giveWater(count: Int, delegate: PresentAlertDelegate) {
        guard count < 50 else {
            delegate.presentAlert(message: "50개 이상의 물은 한 번에 먹을 수 없어요!")
            return
        }
        updateLevel()
        tamagochi.water += count
    }
    
    
    func updateLevel() {
        let energyValue = (Double(tamagochi.rice) / 5) + (Double(tamagochi.water) / 2)
        
        switch energyValue {
        case 0..<20: tamagochi.level = 1
        case 20..<30: tamagochi.level = 2
        case 30..<40: tamagochi.level = 3
        case 40..<50: tamagochi.level = 4
        case 50..<60: tamagochi.level = 5
        case 60..<70: tamagochi.level = 6
        case 70..<80: tamagochi.level = 7
        case 80..<90: tamagochi.level = 8
        case 90..<100: tamagochi.level = 9
        case 100...: tamagochi.level = 10
        default: break
        }
    }
    
    
    func changeType(to newType: TamagochiType) {
        tamagochi.type = newType
    }
    
    
    func getImage() -> UIImage {
        let typeNumber: Int = tamagochi.type.rawValue
        let level: Int = tamagochi.level > 9 ? 9 : tamagochi.level
        
        return UIImage(named: "\(typeNumber)-\(level).png") ?? UIImage()
    }
    
    
    func updateDataBasedUserDefaults(data: Tamagochi) {
        self.tamagochi = data
    }
    
    
    func getSpeechBubbleText() -> String {
        if tamagochi.level >= 10 {
            return "저는 다 자랐어요. 이제 독립할거에요."
        }else {
            return speechBubbleList.randomElement() ?? "저런,, 기본값 말풍선이 나왔네요. 뭐가 문제인지 찾아보세요."
        }
    }
    
    
    func getTamagotchiName() -> String {
        return tamagochi.type.description
    }
    
    
    func getUserName() -> String {
        return userName
    }
    
    
    func changeUserName(to newName: String) {
        self.userName = newName
    }
    
    
    func getTamagotchiInstance() -> Tamagochi {
        return self.tamagochi
    }
    
    
    func getTamagotchiInfo() -> String {
        return "LV \(tamagochi.level) · 밥알 \(tamagochi.rice)개 · 물방울 \(tamagochi.water)개"
    }
}
