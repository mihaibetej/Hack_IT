//
//  DashboardViewController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    static var shouldLaunchHelp = false

    @IBOutlet weak var howAreYouView: UIView!
    @IBOutlet weak var howAreYouViewHeight: NSLayoutConstraint!
    @IBOutlet weak var schedulesView: UIView!
    @IBOutlet weak var routinesView: UIView!
    @IBOutlet weak var theyveWonView: UIView!
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var feelingClosedImageView: UIImageView!
    @IBOutlet weak var feelingOpenedImageView: UIImageView!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var accountButton: UIButton!
    
    let transition = CircularTransition()
    
    @IBAction func openHowIFeel(_ sender: Any) {
        openButton.isHidden = true
        feelingClosedImageView.isHidden = true
        closeButton.isHidden = false
        feelingOpenedImageView.isHidden = false
        howAreYouViewHeight.constant = 125
    }
    
    @IBAction func closeHowIFeel(_ sender: Any) {
        howAreYouViewHeight.constant = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shadowViews: [UIView] = [feelingClosedImageView, feelingOpenedImageView, schedulesView, routinesView, theyveWonView, feedView]
        
        for view in shadowViews {
            view.layer.masksToBounds = false
            view.layer.shadowOpacity = 0.1
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 0, height: 5)
            view.layer.shadowRadius = 10
        }
        
        accountButton.layer.masksToBounds = false
        accountButton.layer.shadowOpacity = 0.7
        accountButton.layer.shadowColor = UIColor.white.cgColor
        accountButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        accountButton.layer.shadowRadius = 5

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if DashboardViewController.shouldLaunchHelp {
            DashboardViewController.shouldLaunchHelp = false
            
            (tabBarController as? CustomTabBarController)?.didTapOnCenterButton(sender: UIButton())
        }
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
        myScheduleViewController.tabBar.selectedIndex = tabIndex
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserProfile" {
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension DashboardViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = accountButton.convert(accountButton.center, to: self.view)
        transition.circleColor = UIColor.white
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint =  accountButton.convert(accountButton.center, to: self.view)
        transition.circleColor = UIColor.white
        
        return transition
    }
}

