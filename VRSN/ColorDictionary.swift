//
//  ColorDictionary.swift
//  VRSN
//
//  Created by Patrick Adams on 10/20/15.
//  Copyright © 2015 Patrick Adams. All rights reserved.
//

import UIKit

class ColorDictionary: NSObject {
    
    let colorOptionsDict = ["Blue", "Green", "Pink", "Purple", "Red", "Orange"]
    
    class func getColorFromString(string: String!) -> UIColor {
        if string == "Blue" {
            return UIColor(red:0, green:0.695, blue:0.877, alpha:1)
        } else if string == "Green" {
            return UIColor(red:0.205, green:0.678, blue:0.213, alpha:1)
        } else if string == "Pink" {
            return UIColor(red:0.823, green:0.413, blue:0.705, alpha:1)
        } else if string == "Purple" {
            return UIColor(red:0.48, green:0.317, blue:0.764, alpha:1)
        } else if string == "Red" {
            return UIColor(red:0.815, green:0.103, blue:0.103, alpha:1)
        } else if string == "Orange" {
            return UIColor(red:1, green:0.498, blue:0, alpha:1)
        } else {
            return UIColor.grayColor()
        }
    }
}
