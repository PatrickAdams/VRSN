//
//  TodayItem.swift
//  Today
//
//  Created by Patrick Adams on 6/22/15.
//  Copyright (c) 2015 Patrick Adams. All rights reserved.
//

import UIKit
import RealmSwift

class ListItem: Object {
    
    dynamic var title: String!
    dynamic var finished = false
    dynamic var important = false
    dynamic var listName: String!
}
