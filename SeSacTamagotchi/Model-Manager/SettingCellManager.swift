//
//  SettingCellManager.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/23.
//

import Foundation


struct SettingCell {
    var title: String
    var image: String
}



struct SettingTableViewManager {
    private var settingCellList: [SettingCell]
    
    private let defaultCell = SettingCell(title: "", image: "")
    
    var count: Int {
        return settingCellList.count
    }
    
    init() {
        settingCellList = [
            SettingCell(title: "내 이름 설정하기", image: "pencil"),
            SettingCell(title: "다마고치 변경하기", image: "moon.fill"),
            SettingCell(title: "데이터 초기화", image: "arrow.clockwise")
        ]
    }
    
    func getCellInfo(at index: Int) -> SettingCell {
        guard index < count else { return defaultCell }
        
        return settingCellList[index]
    }
}
