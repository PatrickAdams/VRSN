//
//  ColorDictionary.swift
//  VRSN
//
//  Created by Patrick Adams on 10/20/15.
//  Copyright © 2015 Patrick Adams. All rights reserved.
//

import UIKit

class ColorDictionary: NSObject {
    
    let colorOptionsDict = ["Blue", "Green", "Pink", "Purple", "Red", "Orange", "Yellow"]
    
    class func getColorFromString(string: String!) -> UIColor {
        if string == "Blue" {
            return UIColor(red:0, green:0.695, blue:0.877, alpha:1)
        } else if string == "Green" {
            return UIColor(red:0.526, green:0.877, blue:0, alpha:1)
        } else if string == "Pink" {
            return UIColor(red:1, green:0.663, blue:0.932, alpha:1)
        } else if string == "Purple" {
            return UIColor(red:0.75, green:0.494, blue:0.843, alpha:1)
        } else if string == "Red" {
            return UIColor(red:1, green:0.359, blue:0.359, alpha:1)
        } else if string == "Orange" {
            return UIColor(red:1, green:0.623, blue:0.315, alpha:1)
        } else if string == "Yellow" {
            return UIColor(red:0.96, green:0.936, blue:0, alpha:1)
        } else {
            return UIColor.grayColor()
        }
    }
}
