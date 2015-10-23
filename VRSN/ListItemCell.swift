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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLongPressGesture()
    }
    
    func updateLabel() {
        if listItem!.important == true {
            listItemTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: listItemTitleLabel.font.pointSize)
        } else {
            listItemTitleLabel.font = UIFont(name: "AvenirNext-Medium", size: listItemTitleLabel.font.pointSize)
        }
    }
    
    func setUpLongPressGesture() {
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 1.0
        lpgr.delegate = self
        self.addGestureRecognizer(lpgr)
    }
    
    func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            if listItemTitleLabel.font == UIFont(name: "AvenirNext-Bold", size: listItemTitleLabel.font.pointSize) {
                listItemTitleLabel.font = UIFont(name: "AvenirNext-Medium", size: listItemTitleLabel.font.pointSize)
                markItemAsNotImportant(listItem)
            } else {
                listItemTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: listItemTitleLabel.font.pointSize)
                markItemAsImportant(listItem)
            }
        }
    }
    
    func markItemAsImportant(todayItem: ListItem!) {
        try! realm.write {
            self.listItem!.important = true
        }
    }
    
    func markItemAsNotImportant(todayItem: ListItem!) {
        try! realm.write {
            self.listItem!.important = false
        }
    }
}
