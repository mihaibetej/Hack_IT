//
//  MyScheduleViewController.swift
//  TBD
//
//  Created by George Muntean on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit
import EventKitUI

class MyScheduleViewController: UIViewController, EKEventEditViewDelegate {

    var tabBar: UITabBarController!
    var calendarViewController: CalendarViewController!
    var routinesViewController: RoutinesViewController!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
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
    
    @IBAction func DidTapAddButton(_ sender: UIBarButtonItem) {
        
        let eventViewController: EKEventEditViewController = EKEventEditViewController()
        eventViewController.editViewDelegate = self
        
        let store = EKEventStore()
        eventViewController.eventStore = store
        
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                self.present(eventViewController, animated: true)
            }
            
        case .notDetermined:
            store.requestAccess(to: .event) { granted , _ in
                if granted == true {
                   self.present(eventViewController, animated: true)
                }
            }
        case .denied, .restricted:
            break
        }
        
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        self.dismiss(animated: true)
    }
}
