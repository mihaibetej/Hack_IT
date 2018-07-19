//
//  MyScheduleViewController.swift
//  TBD
//
//  Created by George Muntean on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class MyScheduleViewController: UIViewController {
    
    var tabBar: UITabBarController!
    var calendarViewController: CalendarViewController!
    var routinesViewController: RoutinesViewController!
    
    @IBAction func segmentedControlDidToggle(_ sender: UISegmentedControl) {
        tabBar.selectedIndex = sender.selectedSegmentIndex
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedTabBar":
            tabBar = segue.destination as! UITabBarController
            calendarViewController = tabBar.viewControllers![0] as! CalendarViewController
            routinesViewController = tabBar.viewControllers![1] as! RoutinesViewController
            routinesViewController.delegate = calendarViewController
        default:
            break
        }
    }
}
