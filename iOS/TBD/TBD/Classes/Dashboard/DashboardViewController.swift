//
//  DashboardViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var howAreYouView: UIView!
    @IBOutlet weak var schedulesView: UIView!
    @IBOutlet weak var routinesView: UIView!
    @IBOutlet weak var theyveWonView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shadowViews: [UIView] = [howAreYouView, schedulesView, routinesView, theyveWonView, feedView]
        
        for view in shadowViews {
            view.layer.masksToBounds = false
            view.layer.shadowOpacity = 0.1
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 5)
            view.layer.shadowRadius = 10
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnHowAreYouFeelingButton(_ sender: UIButton) {
        print("How are you feeling")
    }
    
    @IBAction func didTapOnAccountButton(_ sender: UIButton) {
        print("Account")
    }
    
    @IBAction func didTapOnSchedules(_ sender: UIButton) {
        print("Schedules")
        navigateToMySchedules(tabIndex: 0)
    }
    
    @IBAction func didTapOnRoutines(_ sender: UIButton) {
        print("Routines")
        navigateToMySchedules(tabIndex: 1)
    }
    
    @IBAction func didTapOnTheyveWonTheFight(_ sender: UIButton) {
        print("They've won the fight!")
    }
    
    @IBAction func didTapOnFeed(_ sender: UIButton) {
        print("Feed")
    }
    
    private func navigateToMySchedules(tabIndex: Int) {
        
        tabBarController?.selectedIndex = 1
        guard let navController = tabBarController?.selectedViewController as? UINavigationController else { return }
        guard let myScheduleViewController = navController.topViewController as? MyScheduleViewController else {return}
        
        myScheduleViewController.loadViewIfNeeded()
        myScheduleViewController.segmentedController.selectedSegmentIndex = tabIndex
    }
}
