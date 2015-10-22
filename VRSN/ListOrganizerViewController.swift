//
//  ListOrganizerViewController.swift
//  VRSN
//
//  Created by Patrick Adams on 10/19/15.
//  Copyright © 2015 Patrick Adams. All rights reserved.
//

import UIKit
import RealmSwift

class ListOrganizerViewController: UIViewController {

    let realm = try! Realm()
    let colorOptionsDict = ["Blue", "Green", "Pink", "Purple", "Red", "Orange"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavBar()
        setupTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func styleNavBar() {
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 19)!, NSForegroundColorAttributeName: UIColor.whiteColor()];
        closeButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!, NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 44
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        textField.returnKeyType = UIReturnKeyType.Next
    }
    
    func addItemToList(string: String) {
        if textField.text != "" {
            let list = List()
            list.title = textField.text
            list.dateCreated = NSDate()
            showColorOptionsForList(list)
        }
    }
    
    func showColorOptionsForList(list: List) {
        
        let actionSheet = UIAlertController(title: "Choose a color", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        for color in colorOptionsDict {
            actionSheet.addAction(UIAlertAction(title: color, style: UIAlertActionStyle.Default, handler: { (alertAction: UIAlertAction) -> Void in
                list.color = color
                let realm = try! Realm()
                try! realm.write {
                    realm.add(list)
                }
                self.textField.text = ""
                self.tableView.reloadData()
                NSNotificationCenter.defaultCenter().postNotificationName("refreshPageView", object: self)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func plusButtonTapped() {
        addItemToList(textField.text!)
    }
    
    @IBAction func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ListOrganizerViewController: UINavigationBarDelegate {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
}

extension ListOrganizerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addItemToList(textField.text!)
        return true
    }
}

extension ListOrganizerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(List).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ListItemCell
        let item = realm.objects(List).sorted("dateCreated")[indexPath.row]
        
        cell.listItemTitleLabel?.text = item.title
        cell.listItemTitleLabel.textColor = ColorDictionary.getColorFromString(item.color)
        
        cell.list = item
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if realm.objects(List).count == 1 {
            return false;
        } else {
           return true;
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let item = realm.objects(List).sorted("dateCreated")[indexPath.row]
            try! realm.write {
                self.realm.delete(item)
                self.tableView.reloadData()
                NSNotificationCenter.defaultCenter().postNotificationName("refreshPageView", object: self)
            }
        }
    }
}
