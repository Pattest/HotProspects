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

    let saveKey = "SavedData"

    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }

        people = []
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
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
