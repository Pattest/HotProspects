//
//  Prospect.swift
//  HotProspects
//
//  Created by Baptiste Cadoux on 06/07/2022.
//

import Foundation

class Prospect: Identifiable,
                Codable {
    var id = UUID()
    var name = "ID-\(Int.random(in: 0..<1_000_000))"
    var emailAddress = "name@prospect.com"
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]

    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProspects")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
