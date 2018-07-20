//
//  ProfileViewController.swift
//  TBD
//
//  Created by Florin Voicu on 7/20/18.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        closeButton.layer.masksToBounds = false
        closeButton.layer.shadowOpacity = 0.7
        closeButton.layer.shadowColor = UIColor.white.cgColor
        closeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        closeButton.layer.shadowRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
