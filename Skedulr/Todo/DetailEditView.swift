//
//  DetailEditView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//
import SwiftUI

struct DetailEditView: View {
    @Binding var todo: ToDo
    @Binding var classes: [SingleClass]
    @Binding var completed: [ToDo]
    @Binding var todos: [ToDo]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Form{
            if(todo.state == false){
                Button(action: {
                    todo.state = true
                    completed.append(todo)
                    todos.removeAll(where: { $0 == todo})
                    dismiss()
                }){
                    HStack{
                        Spacer()
                        Text("Mark Completed")
                        Spacer()
                    }
                }
            }else{
                Button(action: {
                    todo.state = false
                    todos.append(todo)
                    completed.removeAll(where: { $0 == todo})
                    dismiss()
                }){
                    HStack{
                        Spacer()
                        Text("Mark Incomplete")
                        Spacer()
                    }
                }
            }
            Section(header: Text("Task Info")){
                TextField("Title", text: $todo.title)
                ClassPicker(selection: $todo.section, classList: $classes)
                DatePicker("Due Date", selection: $todo.deletionTime)
            }
        }
    }
}


#Preview {
    DetailEditView(todo: .constant(ToDo.sampleData[0]), classes: .constant(SingleClass.sampleData), completed: .constant(ToDo.sampleData), todos: .constant(ToDo.sampleData))
}
