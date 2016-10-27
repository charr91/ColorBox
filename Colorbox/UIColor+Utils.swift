//
//  UIColor+Utils.swift
//  Colorbox
//
//  Created by Cliff Harris on 10/26/16.
//  Copyright © 2016 Clifford Harris. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let colorRed = CGFloat(red)/255
        let colorGreen = CGFloat(green)/255
        let colorBlue = CGFloat(blue)/255
        
        self.init(red: colorRed, green: colorGreen, blue: colorBlue, alpha: 1.0)
    }
}
