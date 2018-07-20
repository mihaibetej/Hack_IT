//
//  StoriesViewController.swift
//  TBD
//
//  Created by Stefan Olaru on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
    @IBOutlet weak var first: UIButton!
    @IBOutlet weak var third: UIButton!
    @IBOutlet weak var second: UIButton!
    
    
    
    let transition = CircularTransition()
    
    
    @IBAction func firstAction(_ sender: Any) {
        let modalVC = storyboard?.instantiateViewController(withIdentifier: String.init(describing: WebViewController.self)) as! WebViewController
        
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .custom
        modalVC.youtubeURL = "f6rSuJ2YheQ"
        
        self.present(modalVC, animated: true, completion: nil)
    }
    
    @IBAction func secondAction(_ sender: Any) {
        let modalVC = storyboard?.instantiateViewController(withIdentifier: String.init(describing: WebViewController.self)) as! WebViewController
        
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .custom
        modalVC.youtubeURL = "M5QBH3wDrQY"
        
        self.present(modalVC, animated: true, completion: nil)
    }
    
    @IBAction func thirdAction(_ sender: Any) {
        let modalVC = storyboard?.instantiateViewController(withIdentifier: String.init(describing: WebViewController.self)) as! WebViewController
        
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .custom
        modalVC.youtubeURL = "MFuRqKQwxKA"
        
        self.present(modalVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        first.layer.masksToBounds = false
        first.layer.shadowOpacity = 0.1
        first.layer.shadowColor = UIColor.black.cgColor
        first.layer.shadowOffset = CGSize(width: 0, height: 5)
        first.layer.shadowRadius = 10
        
        second.layer.masksToBounds = false
        second.layer.shadowOpacity = 0.1
        second.layer.shadowColor = UIColor.black.cgColor
        second.layer.shadowOffset = CGSize(width: 0, height: 5)
        second.layer.shadowRadius = 10
        
        third.layer.masksToBounds = false
        third.layer.shadowOpacity = 0.1
        third.layer.shadowColor = UIColor.black.cgColor
        third.layer.shadowOffset = CGSize(width: 0, height: 5)
        third.layer.shadowRadius = 10
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIViewControllerTransitioningDelegate
extension StoriesViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.white
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint =  CGPoint.init(x: 0, y: self.view.frame.height)
        transition.circleColor = UIColor.white
        
        return transition
    }
}
