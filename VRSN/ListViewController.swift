//
//  ListViewController.swift
//  VRSN
//
//  Created by Patrick Adams on 10/19/15.
//  Copyright © 2015 Patrick Adams. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {

    let realm = try! Realm()
    
    var list: List!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var listsButton: UIBarButtonItem!
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavBar()
        setupTableView()
        navBar.topItem?.title = list.title
        navBar.barTintColor = ColorDictionary.getColorFromString(list.color)
        plusButton.setTitleColor(ColorDictionary.getColorFromString(list.color), forState: UIControlState.Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func styleNavBar() {
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 19)!, NSForegroundColorAttributeName: UIColor.whiteColor()];
        clearButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        listsButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 44
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        textField.returnKeyType = UIReturnKeyType.Next
    }
    
    func addItemToList(string: String) {
        if textField.text != "" {
            let listItem = ListItem()
            listItem.title = textField.text
            listItem.listName = list.title
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(listItem)
            }
        }
        
        textField.text = ""
        tableView.reloadData()
    }
    
    func markItemAsComplete(todayItem: ListItem) {
        try! realm.write {
            todayItem.finished = true
        }
    }
    
    func markItemAsNotComplete(todayItem: ListItem) {
        try! realm.write {
            todayItem.finished = false
        }
    }
    
    @IBAction func clearCompletedItems() {
        let predicate = NSPredicate(format: String(format: "finished == true AND listName == '%@'", list.title))
        let completedItems = realm.objects(ListItem).filter(predicate)
        
        try! realm.write {
            self.realm.delete(completedItems)
        }
        
        tableView.reloadData()
    }
    
    @IBAction func plusButtonTapped() {
        addItemToList(textField.text!)
    }
}

extension ListViewController: UINavigationBarDelegate {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
}

extension ListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addItemToList(textField.text!)
        return true
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let predicate = NSPredicate(format:"listName == %@", list.title)
        return realm.objects(ListItem).filter(predicate).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ListItemCell
        let predicate = NSPredicate(format:"listName == %@", list.title)
        let item = realm.objects(ListItem).filter(predicate)[indexPath.row]
        
        cell.listItemTitleLabel?.text = item.title
        cell.listItem = item
        
        if item.finished == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        cell.updateLabel()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let predicate = NSPredicate(format: "listName == %@", list.title)
        let item = realm.objects(ListItem).filter(predicate)[indexPath.row]
        if item.finished != true {
            markItemAsComplete(item)
        } else {
            markItemAsNotComplete(item)
        }
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}