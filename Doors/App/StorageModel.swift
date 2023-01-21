//
//  StorageModel.swift
//  Doors
//
//  Created by Valery Keplin on 14.01.23.
//

import Foundation

class StorageModel {
    
    static let shared = StorageModel()
    var doors: [DoorModel] = []
    
    private let networkingManager = NetworkingManager()
    
    init() {
        self.loadData()
    }
    
    func loadData() {
        networkingManager.downloadDataPseudo { responseData in
            for data in responseData.result {
                DispatchQueue.main.async {
                    self.doors.append(DoorModel(door: data))
                }
            }
        }
    }
}
