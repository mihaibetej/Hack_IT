//
//  CustomTabBarController.swift
//  TBD
//
//  Created by Emanuel Jarnea on 20/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    let centerButton = UIButton(type: .custom)
    
    static var sharedInstance: CustomTabBarController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CustomTabBarController.sharedInstance = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        centerButton.setImage(#imageLiteral(resourceName: "av_3x"), for: .normal)
        let extraWidth = CGFloat(6.0)
        let extraHeight = CGFloat(16.0)
        centerButton.frame = CGRect(x: tabBar.frame.width / 5 * 2 - extraWidth/2, y: -extraHeight*0.75, width: tabBar.frame.width / 5 + extraWidth, height: tabBar.frame.height + extraHeight)
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
        present(controller!, animated: true, completion: nil)
    }
}
