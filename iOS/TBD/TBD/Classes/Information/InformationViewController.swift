//
//  InformationViewController.swift
//  TBD
//
//  Created by Stefan Olaru on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    let transition = CircularTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openSocialMedia(_ sender: Any) {
        let modalVC = storyboard?.instantiateViewController(withIdentifier: String.init(describing: WebViewController.self)) as! WebViewController
        
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .custom
        //modalVC.youtubeURL = "XGcX5wopq3M"
        modalVC.webSiteURL = URL.init(string: "https://www.youtube.com/user/CureLeukaemia1")
        
        self.present(modalVC, animated: true, completion: nil)
    }
    
}


// MARK: - UIViewControllerTransitioningDelegate
extension InformationViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.black
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint =  CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.black
        
        return transition
    }
}
