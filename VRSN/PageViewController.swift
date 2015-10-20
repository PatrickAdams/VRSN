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
        self.setViewControllers([listViewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    func createViewControllers() {
        let lists = realm.objects(List)
        if lists.count > 0 {
            for list in lists {
                let newListViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ListViewController") as! ListViewController
                newListViewController.listTitle = list.title
                listViewControllers.append(newListViewController)
            }
        } else {
            let list = List()
            list.title = "First List"
            list.color = "orange"
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(list)
            }
            let lists = realm.objects(List)
            for list in lists {
                let newListViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ListViewController") as! ListViewController
                newListViewController.listTitle = list.title
                newListViewController.listColor = ColorDictionary.getColorFromString(list.color)
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
