//
//  PageViewController.swift
//  Today
//
//  Created by Patrick Adams on 7/1/15.
//  Copyright (c) 2015 Patrick Adams. All rights reserved.
//

import UIKit
import RealmSwift

class PageViewController: UIPageViewController {
    
    let realm = try! Realm()

    var listViewControllers = [UIViewController]()
    var currentIndex = 0
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self        
        createViewControllers()
        setViewControllers([listViewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshViewControllers", name: "refreshPageView", object: nil)
    }
    
    func refreshViewControllers() {
        listViewControllers = [UIViewController]()
        createViewControllers()
        setViewControllers([listViewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func createViewControllers() {
        let lists = realm.objects(List).sorted("dateCreated")
        if lists.count > 0 {
            for list in lists {
                let newListViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ListViewController") as! ListViewController
                newListViewController.list = list
                listViewControllers.append(newListViewController)
            }
        } else {
            let list = List()
            list.title = "To Do"
            list.color = "Blue"
            list.dateCreated = NSDate()
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(list)
            }
            let lists = realm.objects(List)
            for list in lists {
                let newListViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ListViewController") as! ListViewController
                newListViewController.list = list
                listViewControllers.append(newListViewController)
            }

        }
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let i = listViewControllers.indexOf(viewController)
        currentIndex = i! + 1
        if i == listViewControllers.count - 1 {
            return nil
        } else {
            return listViewControllers[currentIndex]
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let i = listViewControllers.indexOf(viewController)
        currentIndex = i! - 1
        if i == 0 {
            return nil
        } else {
            return listViewControllers[currentIndex]
        }
    }
}
