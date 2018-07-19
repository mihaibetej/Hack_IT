//
//  InformationViewController.swift
//  TBD
//
//  Created by Stefan Olaru on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var winnersButton: UIButton!
    @IBOutlet weak var articlesButton: UIButton!
    @IBOutlet weak var glossaryButton: UIButton!
    @IBOutlet weak var faqButton: UIButton!
    
    let transition = CircularTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        faqButton.layer.masksToBounds = false
        faqButton.layer.shadowOpacity = 0.1
        faqButton.layer.shadowColor = UIColor.black.cgColor
        faqButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        faqButton.layer.shadowRadius = 10
        
        glossaryButton.layer.masksToBounds = false
        glossaryButton.layer.shadowOpacity = 0.1
        glossaryButton.layer.shadowColor = UIColor.black.cgColor
        glossaryButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        glossaryButton.layer.shadowRadius = 10
        
        winnersButton.layer.masksToBounds = false
        winnersButton.layer.shadowOpacity = 0.1
        winnersButton.layer.shadowColor = UIColor.black.cgColor
        winnersButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        winnersButton.layer.shadowRadius = 10
        
        articlesButton.layer.masksToBounds = false
        articlesButton.layer.shadowOpacity = 0.1
        articlesButton.layer.shadowColor = UIColor.black.cgColor
        articlesButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        articlesButton.layer.shadowRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func articlesAction(_ sender: Any) {
        
    }
    
    @IBAction func winnerAction(_ sender: Any) {
        
    }
    
    @IBAction func faqAction(_ sender: Any) {
        
    }
    
    @IBAction func glossaryAction(_ sender: Any) {
        
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
