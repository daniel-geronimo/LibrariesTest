//
//  TabBarController.swift
//  LibrariesTest
//
//  Created by Daniel Zaharia on 16/10/2019.
//  Copyright © 2019 Daniel Zaharia. All rights reserved.
//

import UIKit
import Motion

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        isMotionEnabled = true
        motionTabBarTransitionType = .push(direction: .left)
        motionTabBarTransitionType = .autoReverse(presenting: .push(direction: .left))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
