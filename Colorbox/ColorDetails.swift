//
//  ColorDetails.swift
//  Colorbox
//
//  Created by Cliff Harris on 10/26/16.
//  Copyright © 2016 Clifford Harris. All rights reserved.
//

import Foundation
import UIKit

struct RGB {
    let red: Int
    let green: Int
    let blue: Int
}

struct ColorDetails {
    let hex: String?
    let name: String?
    let description: String?
    var rgb: RGB?
    
    init(hex: String?, name: String?, description: String?, rgb: [Int]) {
        self.hex = hex
        self.name = name
        self.description = description
        if rgb.count == 3 {
            self.rgb = RGB(red: rgb[0], green: rgb[1], blue: rgb[2])
        }
    }
    
    func getUIColor() -> UIColor? {
        guard let rgb = rgb else {
            return nil
        }
        return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue)
    }
}
