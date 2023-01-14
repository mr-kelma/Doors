//
//  ResponseResult.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

struct ResponseResult: Codable {
    let result: [Door]
}

struct Door: Codable {
    let name: String
    let place: String
    var condition: String
}
