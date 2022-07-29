//
//  UserDefaultManager.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import Foundation


enum UserDefaultsKey: String, CaseIterable {
    case userName
    case tamagotchi
    case isDataStored
}



@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            if let value = UserDefaults.standard.object(forKey: self.key) as? T {
                return value
            }else {
                if let value = UserDefaults.standard.data(forKey: self.key) {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(Tamagochi.self, from: value)
                        return decodedData as! T
                    }
                    catch {
                        return defaultValue
                    }
                }else {
                    return defaultValue
                }
                
            }
        }
        set {
            if let tamagotchiValue = newValue as? Tamagochi {
                let encoder = JSONEncoder()
                do {
                    let encodedData = try encoder.encode(tamagotchiValue)
                    UserDefaults.standard.set(encodedData, forKey: self.key)
                }
                catch {
                    return
                }
            }else {
                UserDefaults.standard.set(newValue, forKey: self.key)
            }
        }
    }
}



// 시뮬레이터에서 저장이 잘 안되는 문제 발생.. 폰으로 빌드하면 잘 저장됨...
class UserDefaultManager {
    static var shared = UserDefaultManager()
    
    private init() {}
    
    
    @UserDefault(key: UserDefaultsKey.userName.rawValue, defaultValue: "대장")
    var userName: String
    
    
    @UserDefault(key: UserDefaultsKey.tamagotchi.rawValue, defaultValue: Tamagochi(type: .none))
    var tamagotchi: Tamagochi {
        didSet {
            isDataStored = true
        }
    }
    
    
    @UserDefault(key: UserDefaultsKey.isDataStored.rawValue, defaultValue: false)
    var isDataStored: Bool
    
    
    func resetAllData() {
        // 1.
        //UserDefaultsKey.allCases.forEach { UserDefaults.standard.removeObject(forKey: $0.rawValue) }
        
        // 2.
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
