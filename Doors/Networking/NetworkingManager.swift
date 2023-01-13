//
//  NetworkingManager.swift
//  Doors
//
//  Created by Valery Keplin on 12.01.23.
//

import Foundation

class NetworkingManager {
    
    private let apiAddress = "http://api.doors.org/data/***"
    
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
                let response = try JSONDecoder().decode(ResponseResult.self, from: responseData)
                completionHandler(response)
            } catch {
                print(error)
            }
        }.resume()
    }
}
