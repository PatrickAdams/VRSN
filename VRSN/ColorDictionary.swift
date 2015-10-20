//
//  ColorDictionary.swift
//  VRSN
//
//  Created by Patrick Adams on 10/20/15.
//  Copyright © 2015 Patrick Adams. All rights reserved.
//

import UIKit

class ColorDictionary: NSObject {
    
    class func getColorFromString(string: String!) -> UIColor {
        if string == "orange" {
            return UIColor(red:1, green:0.696, blue:0.063, alpha:1)
        } else if string == "green" {
            return UIColor(red:0.563, green:0.856, blue:0.49, alpha:1)
        } else {
            return UIColor(red:1, green:1, blue:1, alpha:1)
        }
    }
}
