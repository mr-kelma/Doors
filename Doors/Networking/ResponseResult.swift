//
//  ResponseResult.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

enum Condition: String, Codable {
    case Locked
    case Unlocking
    case Unlocked
}

struct Door: Codable {
    let name: String
    let place: String
    var condition: Condition
    var color: String {
        switch condition {
        case Condition.Locked:
            return "blueColor"
        case Condition.Unlocking:
            return "greyColor"
        default:
            return "lightBlueColor"
        }
    }
}

struct ResponseResult: Codable {
    let result: [Door]
}
