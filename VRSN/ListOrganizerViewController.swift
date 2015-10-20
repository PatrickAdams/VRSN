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
            //Pick a random string of color name (orange, blue, green, yellow, purple, pink)
            list.color = "orange"
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(list)
            }
        }
        textField.text = ""
        tableView.reloadData()
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
        let item = realm.objects(List)[indexPath.row]
        
        cell.listItemTitleLabel?.text = item.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
