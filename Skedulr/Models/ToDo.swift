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
        content.title = "\(title)"
        content.body = "Your task is due in 30 min"
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
        ToDo(title: "", section: SingleClass.genericClass, deletionTime: Date(timeIntervalSinceNow: 100))
    }
    
    private mutating func startDeletionTimer() {
        guard Date() < deletionTime else { return }

        // Calculate the time interval until deletionTime
        let timeInterval = deletionTime.timeIntervalSinceNow

        // Create a timer to periodically check for deletion
        self.deletionTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [self] _ in
            if self.shouldDelete() {
                let localSelf = self // Capture as an immutable copy
                print("Deleting ToDo item: \(localSelf.title)")

                // Call an asynchronous function here using 'await' if needed
                Task {
                    await ToDoStore.shared.deleteToDoItem(ToDo: localSelf)
                }
            }
        }
    }

        // Stop the deletion timer when it's no longer needed
    private mutating func stopDeletionTimer() {
            deletionTimer?.invalidate()
            deletionTimer = nil
        }
    enum CodingKeys: String, CodingKey {
            case title
            case id
            case section
            case state
            case deletionTime
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try container.decode(String.self, forKey: .title)
            self.id = try container.decode(UUID.self, forKey: .id)
            self.section = try container.decode(SingleClass.self, forKey: .section)
            self.state = try container.decode(Bool.self, forKey: .state)
            self.deletionTime = try container.decode(Date.self, forKey: .deletionTime)
            startDeletionTimer()
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(title, forKey: .title)
            try container.encode(id, forKey: .id)
            try container.encode(section, forKey: .section)
            try container.encode(state, forKey: .state)
            try container.encode(deletionTime, forKey: .deletionTime)
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

