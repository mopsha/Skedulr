//
//  SkedulrApp.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/1/23.
//

import SwiftUI

@main
struct SkedulrApp: App {
    @StateObject private var store = ToDoStore()
    @StateObject private var class_store = ClassStore()
    @StateObject private var completed_store = CompletedStore()
    @State private var errorWrapper: ErrorWrapper?
    
    private func requestNotificationPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                    print("Notification permission granted.")
                } else if let error = error {
                    print("Error requesting notification permissions: \(error.localizedDescription)")
                }
            }
        }
    
    var body: some Scene {
        WindowGroup {
            MainView(todos: $store.todos, classes: $class_store.clas, completed: $completed_store.todos){
                Task{
                    do{
                        try await store.save(todos: store.todos)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task{
                if !UserDefaults.standard.bool(forKey: "NotificationPermissionRequested") {
                    requestNotificationPermission()
                    UserDefaults.standard.set(true, forKey: "NotificationPermissionRequested")
                }
            }
            .task{
                do{
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Skedulr will load sample data and continue.")
                }
            }
            .task{
                do{
                    try await class_store.save(classes: class_store.clas)
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                }
            }
            .task{
                do{
                    try await class_store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Skedulr will load sample data and continue.")
                }
            }
            .task{
                do{
                    try await completed_store.save(todos: completed_store.todos)
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                }
            }
            .task{
                do{
                    try await completed_store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Skedulr will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper){
                store.todos = ToDo.sampleData
                class_store.clas = SingleClass.sampleData
            }content:{wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
