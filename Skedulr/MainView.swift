//
//  MainView.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/5/23.
//

import SwiftUI
import UserNotifications

struct MainView: View {
    @Binding var todos: [ToDo]
    @Binding var classes: [SingleClass]
    @Binding var completed: [ToDo]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        NavigationStack{
            Text("SKEDULR")
                .font(.title)
            List{
                NavigationLink(destination: ToDoView(todos: $todos, classes: $classes, completed: $completed)){
                    Label("View Todos", systemImage: "checklist.unchecked")
                }
                NavigationLink(destination: CompletedView(completed: $completed, todos: $todos, classes: $classes)){
                    Label("View Completed", systemImage: "checklist.checked")
                }
                NavigationLink(destination: ClassesView(classes: $classes)){
                    Label("View Classes", systemImage: "studentdesk")
                }
                .onChange(of: scenePhase){ phase in
                    if phase == .inactive { saveAction() }
                }
            }
        }
    }
}
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
    if granted {
        // User granted permission
        print("Notification permission granted")
    } else if let error = error {
        // Handle error
        print("Error requesting notification permission: \(error.localizedDescription)")
    }
}
#Preview {
    MainView(todos: .constant(ToDo.sampleData), classes: .constant(SingleClass.sampleData), completed: .constant(ToDo.sampleData), saveAction: {})
}
