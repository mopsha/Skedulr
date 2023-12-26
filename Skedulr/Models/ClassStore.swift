//
//  ClassStore.swift
//  Skedulr
//
//  Created by Michael Opsha on 12/4/23.
//

import Foundation

@MainActor
class ClassStore: ObservableObject{
    @Published var clas: [SingleClass] = []
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("class.data")
    }
    
    func load() async throws {
        let task = Task<[SingleClass], Error>{
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else{
                return[]
            }
            let classes = try JSONDecoder().decode([SingleClass].self, from: data)
            return classes
        }
        let classes = try await task.value
        self.clas = classes
    }
    
    func save(classes: [SingleClass]) async throws {
        let task = Task{
            let data = try JSONEncoder().encode(classes)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
