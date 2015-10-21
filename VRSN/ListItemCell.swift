//
//  TodayItemCell.swift
//  Today
//
//  Created by Patrick Adams on 6/22/15.
//  Copyright (c) 2015 Patrick Adams. All rights reserved.
//

import UIKit
import RealmSwift

class ListItemCell: UITableViewCell {
    
    var listItem: ListItem?
    var list: List?
    let realm = try! Realm()
    @IBOutlet weak var listItemTitleLabel: UILabel!
}
