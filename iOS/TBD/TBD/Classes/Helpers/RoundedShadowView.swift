//
//  UIView+applyShadow.swift
//  TBD
//
//  Created by George Muntean on 19/07/2018.
//  Copyright © 2018 Shivering Singletons. All rights reserved.
//

import Foundation
import UIKit

class RoundedShadowView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.cornerRadius = 10
    }

}
