//
//  ThemeView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/5/23.
//

import SwiftUI

struct ThemeView: View {
    let theme : Theme
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(theme.mainColor)
            .foregroundColor(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
#Preview {
    ThemeView(theme: .bubblegum)
}
