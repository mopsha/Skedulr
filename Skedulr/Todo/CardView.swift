//
//  CardView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/1/23.
//

import SwiftUI

struct CardView: View {
    var todo: ToDo
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "circle")
                Text(todo.title)
            }
            Spacer()
        }
            .padding()
    }
}

#Preview{
    CardView(todo: ToDo.sampleData[0])
}
