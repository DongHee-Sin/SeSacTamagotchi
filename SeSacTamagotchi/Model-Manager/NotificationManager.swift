//
//  NotificationManager.swift
//  SeSacTamagotchi
//
//  Created by 신동희 on 2022/07/29.
//

import Foundation
import UserNotifications


class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() {}
    
    let notification = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        
        notification.requestAuthorization(options: authorizationOptions) { [unowned self] success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    
    func sendNotification() {
        let notificationCenter = UNMutableNotificationContent()
        
        if UserDefaultManager.shared.isDataStored {
            notificationCenter.title = "\(UserDefaultManager.shared.userName)님! 밥주세요!"
            notificationCenter.body = "\(UserDefaultManager.shared.tamagotchi.type.description) 굶어 죽겠어요!"
        }else {
            notificationCenter.title = "다마고치를 한번 키워보세요"
            notificationCenter.body = "보람찬 다마고치 키우기! 시간 가는줄 모르겠네!"
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationCenter, trigger: trigger)
        
        notification.add(request)
    }
    
    func removeAllNotification() {
        notification.removeAllPendingNotificationRequests()
    }
}
