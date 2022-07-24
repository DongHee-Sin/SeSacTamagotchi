//
//  TamagotchiCellManager.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import UIKit


struct TamagotchiCellInfo {
    let type: TamagochiType
    let imageString: String
    let description: String
}



struct TamagotchiCollectionViewManager {
    
    private var tamagotchiList: [TamagotchiCellInfo]
    
    private let defaultCell = TamagotchiCellInfo(type: .none, imageString: "noImage", description: "준비중이에요")
    
    var count: Int { return tamagotchiList.count }
    
    
    
    init() {
        tamagotchiList = [
            TamagotchiCellInfo(type: .sting, imageString: "1-6", description: "따끔따끔 다마고치입니당~ 키는 200km 몸무게는 200톤이에용~\n성격은 이름처럼 따끔합니당~\n잘먹으니까 밥은 자주 주셔야되구요\n물도 잘 주셔야되는디~\n감당할 수 있쥬?"),
            TamagotchiCellInfo(type: .smail, imageString: "2-6", description: "방실방실 다마고치입니당 키는 100km 몸무게는 150톤이에용\n성격은 화끈하고 날아다닙니다~\n열심히 잘 먹고 잘 클 자신\n있습니당~ 방실!~!"),
            TamagotchiCellInfo(type: .twinkle, imageString: "3-6", description: "반짝반짝 다마고치입니당~ 키는 1cm 몸무게는 1g입니당~\n 겁나게 작지만 겁나 반짝거려서 잘 보입니당~\n저는 크로와상을 참 좋아합니당~\n입맛이 좀 까다로운 편입니당~")
        ]
    }
    
    
    
    func getTamagotchiCellInfo(at index: Int) -> TamagotchiCellInfo {
        guard index < tamagotchiList.count else { return defaultCell }
        
        return tamagotchiList[index]
    }
}
