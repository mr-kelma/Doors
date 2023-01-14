//
//  Door.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

enum Condition: String, Codable {
    case Locked
    case Unlocking
    case Unlocked
    
    init?(rawValue: String) {
        switch rawValue {
        case "Unlocked": self = .Unlocked
        case "Unlocking": self = .Unlocking
        default: self = .Locked
        }
    }
}

struct DoorModel: Codable {
    let name: String
    let place: String
    var condition: Condition
    var color: String {
        switch condition {
        case Condition.Locked:
            return C.Colors.blueColor
        case Condition.Unlocking:
            return C.Colors.greyColor
        default:
            return C.Colors.lightBlueColor
        }
    }
    
    init(door: Door) {
        self.name = door.name
        self.place = door.place
        self.condition = Condition(rawValue: door.condition) ?? Condition.Locked
    }
}
