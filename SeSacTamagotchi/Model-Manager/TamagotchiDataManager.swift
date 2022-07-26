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
    
    // MARK: - Propertys
    static let shared = TamagotchiDataManager()
    
    private var tamagochi: Tamagochi
    private var _userName: String
    
    var tamagotchiName: String { return tamagochi.type.description }
    
    var userName: String { return self._userName }
    
    var tamagotchiInstance: Tamagochi { return self.tamagochi }

    var tamagotchiInfoString: String { return "LV \(tamagochi.level) · 밥알 \(tamagochi.rice)개 · 물방울 \(tamagochi.water)개" }
    
    
    
    // MARK: - Init
    private init() {
        self.tamagochi = UserDefaultManager.shared.tamagotchi
        self._userName = UserDefaultManager.shared.userName
    }
    

    
    // MARK: - Methods
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
        guard self.tamagochi.level < 10 else { return }
        
        let energyValue = (Double(tamagochi.rice) / 5) + (Double(tamagochi.water) / 2)
        
        let level = Int(energyValue / 10)
        
        if 1...10 ~= level {
            tamagochi.level = level
        }else if level < 1 {
            tamagochi.level = 1
        }else {
            print("Level 계산 오류")
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
    
    
    func changeUserName(to newName: String) {
        self._userName = newName
    }
    
    
    func getSpeechBubbleText() -> String {
        var speechBubbleList: [String] = []
        
        if tamagochi.level < 10 {
            speechBubbleList = [
                "\(_userName)님 커밋 푸시 하셨나요?",
                "복습 아직 안하셨다구요? 지금 잠이 오세요? \(_userName)님???",
                "\(_userName)님! 과제할 시간이네요!",
                "\(_userName)님 잠은 죽어서 자는 것도 나쁘지 않을 것 같아요.",
                "전 아직 배고파요 \(_userName)님 먹을걸 더 주세요",
                "테이블뷰컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요?",
                "\(_userName)님, 야식 메뉴로는 어떤게 좋을까요?"
            ]
        }else {
            speechBubbleList = [
                "\(_userName)님 저는 이제 다 자랐어요.",
                "악 - 다마고치 배 터진다",
                "키워주셔서 감사합니다 \(_userName)님\n이제 저는 독립할거에요.",
                "\(_userName)님 다른 다마고치를 또 키워보시는건 어떨까요?",
                "100점짜리 \(_userName)님 *^^*",
                "과제하셔야죠 \(_userName)님, 집중하세요",
                "배불러요..!! 그만 먹이세요"
            ]
        }
        
        return speechBubbleList.randomElement() ?? "저런,, 기본값 말풍선이 나왔네요. 뭐가 문제인지 찾아보세요."
    }
    
    
    func saveUserData() {
        let dataManager = UserDefaultManager.shared
        guard dataManager.isDataStored else {
            return
        }
        dataManager.tamagotchi = tamagochi
        dataManager.userName = userName
    }
}
