//
//  SingleClass.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//

import Foundation

struct SingleClass: Identifiable, Codable, Hashable{
    var title: String
    var id = UUID()
    var theme: Theme
    
    init(title: String, theme: Theme, id: UUID = UUID()){
        self.title = title
        self.theme = theme
        self.id = id
    }
    
    static var genericClass: SingleClass{
        SingleClass(title: "", theme: .white)
    }
}

extension SingleClass {
    static let sampleData: [SingleClass] =
    [
        SingleClass(title: "Comp Sci", theme: .buttercup),
        SingleClass(title: "Calc", theme: .navy),
        SingleClass(title: "Physics", theme: .periwinkle)
    ]
}
