//
//  GridViewController.swift
//  LibrariesTest
//
//  Created by Daniel Zaharia on 17/10/2019.
//  Copyright © 2019 Daniel Zaharia. All rights reserved.
//

import UIKit
import Hero

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}

class GridViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        hero.isEnabled = true
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

extension GridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kCellReuseID", for: indexPath) as! Cell
        cell.label.text = "\(indexPath.row)"
        cell.backgroundColor = .darkGray
        cell.contentView.hero.id = "cell_contentView_\(indexPath.row)"
        cell.contentView.hero.modifiers = [.fade, .scale(0.8)]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 2 * 10) / 3.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Cell
        let heroId = "cell\(indexPath.row)"
        cell.hero.id = heroId
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "gridDetailVC") as! GridDetailViewController
        vc.heroId = heroId
        
        
        
//        collectionView.hero.isEnabled = true
//        collectionView.hero.modifiers = [.cascade]
//        for cell in collectionView.visibleCells {
//            cell.hero.isEnabled = true
//            cell.hero.modifiers = [.fade, .scale(0.5)]
//        }
        
//        present(vc, animated: true, completion: nil)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension GridViewController: HeroViewControllerDelegate {
    func heroWillStartAnimatingTo(viewController: UIViewController) {
        if (viewController as? GridViewController) != nil {
          collectionView.hero.modifiers = [.cascade(delta:0.015, direction:.bottomToTop, delayMatchedViews:true)]
        } else if (viewController as? GridDetailViewController) != nil {
          let cell = collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!
          collectionView.hero.modifiers = [.cascade(delta: 0.015, direction: .radial(center: cell.center), delayMatchedViews: true)]
        } else {
          collectionView.hero.modifiers = [.cascade(delta:0.015)]
        }
    }
}
