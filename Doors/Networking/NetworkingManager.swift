//
//  NetworkingManager.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

class NetworkingManager {
    
    private let apiAddress = "https://api.doors.org/data/***"
    
    func downloadData(_ completionHandler: @escaping (ResponseResult) -> Void) {
        guard let url = URL(string: apiAddress) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("error in request - \(error)")
                return
            }
            
            guard let resp = response as? HTTPURLResponse,
                  200..<300 ~= resp.statusCode,
                  let responseData = data
            else { return }
            do {
                _ = try JSONDecoder().decode(ResponseResult.self, from: responseData)
                let doorsResponse = ResponseResult(result: [
                        Door(name: "Front door", place: "Home", condition: "Locked"),
                        Door(name: "Front door", place: "Office", condition: "Locked"),
                        Door(name: "Front door", place: "Garage", condition: "Locked"),
                        Door(name: "Front door", place: "Country house", condition: "Locked"),
                        Door(name: "Front door", place: "Shed", condition: "Locked")
                    ])
                completionHandler(doorsResponse)
            } catch {
                print(error)
            }
        }.resume()
    }
}
