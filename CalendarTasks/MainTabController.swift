//
//  ViewController.swift
//  CalendarTasks
//
//  Created by Sergey on 22.10.2021.
//

import UIKit

@available(iOS 13.4, *)
class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBar()
       
    }
    
    func setupBar() {
        
        let calendarViewController = createNavController(vc: CalendarViewController(), itemName: "Calendar", itemImage: "calendar.badge.clock")
        //let tasksViewController = createNavController(vc: TasksViewController(), itemName: "Tasks", itemImage: "text.badge.checkmark")
        
        viewControllers = [calendarViewController]//, //tasksViewController]
        
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String ) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(named: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        
        return navController
    }


}

