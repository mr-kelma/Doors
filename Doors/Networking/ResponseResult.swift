//
//  ResponseResult.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

enum Condition: String, Codable {
    case locked
    case unlocked
    case unlocking
}

struct Door: Codable {
    let name: String
    let place: String
    var condition: Condition
    var color: String {
        switch condition {
        case Condition.locked:
            return "blueColor"
        case Condition.unlocked:
            return "lightBlueColor"
        default:
            return "greyColor"
        }
    }
}


struct ResponseResult: Codable {
    let result: [Door]
}
