//
//  GridDetailViewController.swift
//  LibrariesTest
//
//  Created by Daniel Zaharia on 17/10/2019.
//  Copyright © 2019 Daniel Zaharia. All rights reserved.
//

import UIKit
import Hero

class GridDetailViewController: UIViewController {

    var heroId: String = ""
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hero.isEnabled = true
        contentView.hero.id = heroId
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    
    @objc func close() {
        navigationController?.popViewController(animated: true)
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

