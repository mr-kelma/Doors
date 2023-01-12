//
//  UserDoors.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

struct UserDoors {
    static let doors: [Door] = [
    Door(name: "Front door", place: "Home", condition: ["Locked", "Unocked"], status: true),
    Door(name: "Front door", place: "Office", condition: ["Locked", "Unocked"], status: true),
    Door(name: "Front door", place: "Garage", condition: ["Locked", "Unocked"], status: true),
    Door(name: "Front door", place: "Country house", condition: ["Locked", "Unocked"], status: true)
    ]
}
