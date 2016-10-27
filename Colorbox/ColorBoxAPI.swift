//
//  ColorBoxAPI.swift
//  Colorbox
//
//  Created by Cliff Harris on 10/26/16.
//  Copyright © 2016 Clifford Harris. All rights reserved.
//

import Foundation

final class ColorBoxAPI {
    
    typealias ServiceSuccess = ([ColorDetails]) -> Void
    
    static func fetchColors(completion: @escaping ServiceSuccess) {
        let session = URLSession.shared
        
        let path = "https://s3-us-west-1.amazonaws.com/jh-prototypes/colors.json"
        let url = URL(string: path)
        
        guard let endpoint = url else { return }
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        
        let operation = session.dataTask(with: request, completionHandler: { (data, response, error) in
            print("Server Response: \(response)")
            if let data = data {
                let resultColors = parseColorDetailsFromJson(withData: data)
                completion(resultColors)
            }
            else if let error = error {
                print("Error: \(error)")
            }
        })
        operation.resume()
    }
    
    static func fetchSortedColors(completion: @escaping ServiceSuccess) {
        fetchColors(completion: { result in
            let resultColors: [ColorDetails] = result
            completion(sortColorsByBrightnessDescending(colors: resultColors))
        })
    }
    
    static func sortColorsByBrightnessDescending(colors: [ColorDetails]) -> [ColorDetails] {
        var brightnessMapping: [Double: ColorDetails] = [:]
        for color in colors {
            if let rgb = color.rgb {
                let brightness = (0.241 * Double(rgb.red) + 0.691 * Double(rgb.green) + 0.068 * Double(rgb.blue))
                brightnessMapping[brightness] = color
            }
        }
        
        let sorted = brightnessMapping.sorted { (a, b) -> Bool in
            a.key > b.key
        }
        
        return sorted.flatMap({ $1 })
    }
    
    static private func parseColorDetailsFromJson(withData data: Data) -> [ColorDetails] {
        var resultColors: [ColorDetails] = []
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let results = json?["results"] as? [Any] {
            
            for result in results {
                if let result = result as? [String: Any],
                    let hex = result["hex"] as? String,
                    let name = result["name"] as? String,
                    let desc = result["description"] as? String,
                    let rgb = result["rgb"] as? [Int] {
                    
                    resultColors.append(ColorDetails(hex: hex, name: name, description: desc, rgb: rgb))
                }
            }
        } else {
            print("Error: Invalid json!")
        }
        return resultColors
    }
}
