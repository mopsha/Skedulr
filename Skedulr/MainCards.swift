//
//  MainCards.swift
//  Skedulr
//
//  Created by Michael Opsha on 1/26/24.
//

import SwiftUI

struct MainCards: View {
    var label: String
    var body: some View {
        VStack{
            Spacer()
            Text(label)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    MainCards(label: "yeye")
}
