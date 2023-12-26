//
//  CompletedView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/13/23.
//

import SwiftUI

struct CompletedView: View {
    @Binding var completed: [ToDo]
    @Binding var todos: [ToDo]
    @Binding var classes: [SingleClass]
    var body: some View {
        NavigationStack{
            List($completed){ $complete in
                NavigationLink(destination: DetailEditView(todo: $complete, classes: $classes, completed: $completed, todos: $todos)){
                    CardView(todo: complete)
                }
                .listRowBackground(complete.section.theme.mainColor)
                .foregroundColor(complete.section.theme.accentColor)
            }
            .navigationTitle("Completed")
        }
        .padding()
    }
}

#Preview {
    CompletedView(completed: .constant(ToDo.sampleData), todos: .constant(ToDo.sampleData), classes: .constant(SingleClass.sampleData))
}
