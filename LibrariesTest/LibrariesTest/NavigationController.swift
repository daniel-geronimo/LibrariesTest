//
//  NavigationController.swift
//  LibrariesTest
//
//  Created by Daniel Zaharia on 30/10/2019.
//  Copyright © 2019 Daniel Zaharia. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        isMotionEnabled = true
        motionNavigationTransitionType = .pageIn(direction: .left)
        motionNavigationTransitionType = .autoReverse(presenting: .pageIn(direction: .left))
        
    }
    
}
