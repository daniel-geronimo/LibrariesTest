//
//  IntroViewController.swift
//  LibrariesTest
//
//  Created by Daniel Zaharia on 30/10/2019.
//  Copyright © 2019 Daniel Zaharia. All rights reserved.
//

import UIKit
import Motion

class IntroViewController: UIViewController {

    var buttonOrigin: CGPoint = .zero
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.alpha = 0.0
        
        infoLabel.alpha = 0.0
        infoLabel.animate(.scale(0.2))
        
        buttonOrigin = CGPoint(x: getStartedButton.bounds.origin.x, y: getStartedButton.bounds.origin.y)
        getStartedButton.alpha = 0.0
        getStartedButton.animate(.translate(CGPoint(x: buttonOrigin.x, y: buttonOrigin.y + 50)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        welcomeLabel.animate(.fadeIn, .delay(0))
        infoLabel.animate(.fadeIn, .scale(1), .delay(0.5))
        getStartedButton.animate(.fadeIn, .translate(CGPoint(x: buttonOrigin.x, y: buttonOrigin.y)), .delay(1.0))
    }
    
}
