//
//  Door.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

class DoorModel {
    
    static let shared = DoorModel()
    var doors: [Door] = []
    
//    private let networkingManager = NetworkingManager()
    
    init() {
        self.loadData()
    }
    
    func loadData() {
        print("Making a request to the network")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.doors = [
                Door(name: "Front door", place: "Home", condition: Condition.Locked),
                Door(name: "Front door", place: "Office", condition: Condition.Locked),
                Door(name: "Front door", place: "Garage", condition: Condition.Locked),
                Door(name: "Front door", place: "Country house", condition: Condition.Locked),
                Door(name: "Front door", place: "Shed", condition: Condition.Locked)
            ]
            print("Data received")
        }
    }
}
