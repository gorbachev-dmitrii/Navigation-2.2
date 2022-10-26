//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Dima Gorbachev on 24.10.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UserNotifications

final class LocalNotificationsService {
    
    static var shared = LocalNotificationsService()
    private let center = UNUserNotificationCenter.current()

    func registeForLatestUpdatesIfPossible() {
        center.requestAuthorization(options: [.badge, .provisional, .sound]) { granted, error in
            if granted {
                self.scheduleNotification()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.body = "Посмотрите последние обновления"
        let trigger = UNCalendarNotificationTrigger(dateMatching: createSchedule(), repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    private func createSchedule() -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.timeZone = .current
        return dateComponents
    }
}
