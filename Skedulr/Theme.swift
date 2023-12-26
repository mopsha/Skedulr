//
//  Theme.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/1/23.
import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable{
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    case white
    
    var accentColor: Color{
        switch self{
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow, .white: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String{
        rawValue.capitalized
    }
    
    var id: String{
        name
    }
}