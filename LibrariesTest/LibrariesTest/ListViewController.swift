//
//  ListViewController.swift
//  LibrariesTest
//
//  Created by Daniel Zaharia on 16/10/2019.
//  Copyright © 2019 Daniel Zaharia. All rights reserved.
//

import UIKit
import ViewAnimator

let kCellReuseId: String = "kCellReuseId"

class ListViewController: UIViewController {
    
    var items: Int = 50

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let cells = tableView.visibleCells(in: 0)
        let fromAnimation = AnimationType.from(direction: .bottom, offset: tableView.bounds.height)
        let zoomAnimation = AnimationType.zoom(scale: 0.5)
//        UIView.animate(views: cells, animations: [fromAnimation, fadeAnimation])
        
        UIView.animate(views: cells, animations: [fromAnimation, zoomAnimation], reversed: false,
                       initialAlpha: 0.0, finalAlpha: 1.0, completion: {
            self.items = 50
            self.tableView.reloadData()
        })
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseId, for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
}
