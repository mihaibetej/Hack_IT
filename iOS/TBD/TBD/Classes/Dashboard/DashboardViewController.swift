//
//  DashboardViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    @IBAction func didTapOnRoutines(_ sender: UIButton) {
        print("Routines")
    }
    
    @IBAction func didTapOnTheyveWonTheFight(_ sender: UIButton) {
        print("They've won the fight!")
    }
    
    @IBAction func didTapOnFeed(_ sender: UIButton) {
        print("Feed")
    }
}
