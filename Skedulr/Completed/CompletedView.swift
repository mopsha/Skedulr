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
            List($completed){ $todo in
                if !todo.shouldDelete(){
                    NavigationLink(destination: DetailEditView(todo: $todo, classes: $classes, completed: $completed, todos: $todos)){
                        CardView(todo: todo)
                    }
                    .listRowBackground(todo.section.theme.mainColor)
                }
            }
            .onAppear{
                todos.removeAll { $0.shouldDelete() }
                // Call a method to delete expired items from the backend
                ToDoStore.shared.deleteExpiredItems()
                }
            }
            .navigationTitle("Completed")
            .padding()
        }
}

#Preview {
    CompletedView(completed: .constant(ToDo.sampleData), todos: .constant(ToDo.sampleData), classes: .constant(SingleClass.sampleData))
}
