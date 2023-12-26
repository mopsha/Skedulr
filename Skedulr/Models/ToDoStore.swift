//
//  ToDoStore.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//

import Foundation

@MainActor
class ToDoStore: ObservableObject{
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
            let todos = try JSONDecoder().decode([ToDo].self, from: data)
            return todos
        }
        let todo = try await task.value
        self.todos = todo
    }
    
    func save(todos: [ToDo]) async throws {
        let task = Task{
            let data = try JSONEncoder().encode(todos)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
