//
//  UserDefaultManager.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/22.
//

import Foundation


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
            if let stringValue = newValue as? String {
                UserDefaults.standard.set(stringValue, forKey: self.key)
            }else {
                let encoder = JSONEncoder()
                let newValue = newValue as! Tamagochi
                do {
                    let encodedData = try encoder.encode(newValue)
                    UserDefaults.standard.set(encodedData, forKey: self.key)
                }
                catch {
                    return
                }
            }
        }
    }
}



// 시뮬레이터에서 저장이 잘 안되는 문제 발생.. 폰으로 빌드하면 잘 저장됨...
class UserDefaultManager {
    static var shared = UserDefaultManager()
    
    private init() {}
    
    @UserDefault(key: "userName", defaultValue: "대장")
    var userName: String
    
    
    @UserDefault(key: "tamagotchi", defaultValue: Tamagochi(type: .none))
    var tamagotchi: Tamagochi
}
