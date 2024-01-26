//
//  ToDo.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/1/23.
//

import Foundation
import UserNotifications

struct ToDo: Identifiable, Codable, Equatable{
    var title: String
    var id = UUID()
    var section: SingleClass
    var state: Bool
    var deletionTime: Date
    private var deletionTimer: Timer?
    
    init(title: String, section: SingleClass, id: UUID = UUID(), state: Bool = false, deletionTime: Date){
        self.title = title
        self.section = section
        self.id = id
        self.state = state
        self.deletionTime = deletionTime
        startDeletionTimer()
    }
    
    func shouldDelete() -> Bool {
        return Date() >= deletionTime
    }

    func scheduleNotification() {
        guard Date() < deletionTime else { return }
        let notificationTime = Calendar.current.date(byAdding: .minute, value: -30, to: deletionTime) ?? deletionTime
        let content = UNMutableNotificationContent()
        content.title = "Reminder: \(title)"
        content.body = "Your task '\(title)' is about to be deleted."
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    static var emptyTask: ToDo{
        ToDo(title: "", section: SingleClass.genericClass, deletionTime: Date(timeIntervalSinceNow: 10000000))
    }
    
    private mutating func startDeletionTimer() {
            guard Date() < deletionTime else { return }

            // Calculate the time interval until deletionTime
            let timeInterval = deletionTime.timeIntervalSinceNow

            // Create a timer to periodically check for deletion
                self.deletionTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
                    if self.shouldDelete() {
                        
                        
                }
            }
        }

        // Stop the deletion timer when it's no longer needed
    private mutating func stopDeletionTimer() {
            deletionTimer?.invalidate()
            deletionTimer = nil
        }
}

extension ToDo {
    static let sampleData: [ToDo] =
    [
        ToDo(title: "Design", section: SingleClass(title: "Comp Sci", theme: .sky), deletionTime: Date(timeIntervalSinceNow: 60)),
        ToDo(title: "App Dev", section: SingleClass(title: "Physics", theme: .bubblegum), deletionTime: Date(timeIntervalSinceNow: 10000000)),
        ToDo(title: "Web Dev", section: SingleClass(title: "Calculus", theme: .yellow), deletionTime: Date(timeIntervalSinceNow: 3600))
    ]
}

