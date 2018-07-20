//
//  CustomTabBarController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    let transition = CircularTransition()
    let centerButton = UIButton(type: .custom)
    
    static var sharedInstance: CustomTabBarController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CustomTabBarController.sharedInstance = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        centerButton.setImage(#imageLiteral(resourceName: "help_blue"), for: .normal)
        centerButton.setImage(#imageLiteral(resourceName: "help_orange"), for: .highlighted)
        let extraWidth = CGFloat(6.0)
        let extraHeight = CGFloat(24.0)
        centerButton.frame = CGRect(x: tabBar.frame.width / 5 * 2 - extraWidth/2, y: -extraHeight, width: tabBar.frame.width / 5 + extraWidth, height: tabBar.frame.height + extraHeight)
        tabBar.addSubview(centerButton)
        
        centerButton.addTarget(self, action: #selector(didTapOnCenterButton), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.bringSubview(toFront: centerButton)
    }
    
    @objc func didTapOnCenterButton(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Alfie", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        controller!.transitioningDelegate = self
        controller!.modalPresentationStyle = .custom
        present(controller!, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension CustomTabBarController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = CGPoint.init(x: tabBar.center.x, y: self.view.frame.height - tabBar.bounds.height / 2)
        transition.circleColor = UIColor.white
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint =  CGPoint.init(x: tabBar.center.x, y: self.view.frame.height - tabBar.bounds.height / 2)
        transition.circleColor = UIColor.white
        
        return transition
    }
}
