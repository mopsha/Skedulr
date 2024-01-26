//
//  NewToDo.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/1/23.
//

import SwiftUI

struct NewToDo: View {
    @Binding var addingNew: Bool
    @Binding var todos: [ToDo]
    @Binding var classes: [SingleClass]
    @Binding var completed: [ToDo]
    @State private var newToDo = ToDo.emptyTask
    var body: some View {
        NavigationStack{
            DetailEditView(todo: $newToDo, classes: $classes, completed: $completed, todos: $todos)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction){
                        Button("Dismiss"){
                            addingNew = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Add"){
                            todos.append(newToDo)
                            addingNew = false
                            newToDo.scheduleNotification()
                        }
                    }
                }
        }
    }
}

#Preview {
    NewToDo(addingNew: .constant(true), todos: .constant(ToDo.sampleData), classes: .constant(SingleClass.sampleData), completed: .constant(ToDo.sampleData))
}
