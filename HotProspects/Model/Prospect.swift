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
    @Published var people: [Prospect]

    init() {
        self.people = []
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
