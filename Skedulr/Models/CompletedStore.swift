//
//  CompletedStore.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/13/23.
//

import Foundation

import Foundation

@MainActor
class CompletedStore: ObservableObject{
    static let shared = CompletedStore()
    @Published var todos: [ToDo] = []
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("todo.data")
    }
    
    func load() async throws {
        let task = Task<[ToDo], Error>{
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else{
                return[]
            }
            let completed = try JSONDecoder().decode([ToDo].self, from: data)
            return todos
        }
        let completed = try await task.value
        self.todos = completed
    }
    
    func save(todos: [ToDo]) async throws {
        let task = Task{
            let data = try JSONEncoder().encode(todos)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    func deleteCompleteItem(ToDo: ToDo) async {
        if let index = todos.firstIndex(of: ToDo) {
            todos.remove(at: index)
            do{
                try await save(todos: todos)
            }catch{
                
            }
        }
    }
    func deleteExpiredItems(){
        todos.removeAll { $0.shouldDelete() }
    }
}
