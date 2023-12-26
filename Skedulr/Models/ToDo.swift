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
    var date: Date
    
    init(title: String, section: SingleClass, id: UUID = UUID(), state: Bool = false, date: Date){
        self.title = title
        self.section = section
        self.id = id
        self.state = state
        self.date = date
    }
    
    static var emptyTask: ToDo{
        ToDo(title: "", section: SingleClass.genericClass, date: .now)
    }
}

extension ToDo {
    static let sampleData: [ToDo] =
    [
        ToDo(title: "Design", section: SingleClass(title: "Comp Sci", theme: .sky), date: DateComponents(hour: 23, minute: 59)),
        ToDo(title: "App Dev", section: SingleClass(title: "Physics", theme: .bubblegum), date: DateComponents(hour: 23, minute: 59)),
        ToDo(title: "Web Dev", section: SingleClass(title: "Calculus", theme: .yellow), date: DateComponents(hour: 23, minute: 59))
    ]
}

