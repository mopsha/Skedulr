//
//  ToDoView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/1/23.
//

import SwiftUI

struct ToDoView: View {
    @Binding var todos: [ToDo]
    @Binding var classes: [SingleClass]
    @Binding var completed: [ToDo]
    @State private var addingNew = false
    var body: some View {
        NavigationStack{
            List($todos){ $todo in
                NavigationLink(destination: DetailEditView(todo: $todo, classes: $classes, completed: $completed, todos: $todos)){
                    CardView(todo: todo)
                }
            }
            .navigationTitle("To-Do")
            .toolbar {
                Button(action: {
                    addingNew = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Task")
            }
        }
        .padding()
        .sheet(isPresented: $addingNew){
            NewToDo(addingNew: $addingNew, todos: $todos, classes: $classes, completed: $completed)
        }
    }
}

#Preview{
    ToDoView(todos: .constant(ToDo.sampleData), classes: .constant(SingleClass.sampleData), completed: .constant(ToDo.sampleData))
}
