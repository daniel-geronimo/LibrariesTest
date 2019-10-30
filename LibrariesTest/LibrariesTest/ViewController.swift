//
//  ViewController.swift
//  LibrariesTest
//
//  Created by Daniel Zaharia on 16/10/2019.
//  Copyright © 2019 Daniel Zaharia. All rights reserved.
//

import UIKit
import Pastel
import BLTNBoard
import EZYGradientView
import PMSuperButton
import NVActivityIndicatorView
import MaterialComponents.MaterialButtons
import BEMCheckBox

class TextFieldBulletinPage: BLTNPageItem {

    var textField: UITextField!

    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        textField = interfaceBuilder.makeTextField(placeholder: "Name", returnKey: .done, delegate: self as? UITextFieldDelegate)
        textField.backgroundColor = .lightGray
        textField.tintColor = .darkGray
        return [textField]
    }
    
}


class ViewController: UIViewController {
    
    var bulletinManager: BLTNItemManager!
    var notificationsPageItem: BLTNPageItem!
    var namePageItem: TextFieldBulletinPage!
    
    @IBOutlet weak var materialButton: MDCButton!
    
    @IBOutlet weak var gradientView: EZYGradientView!
    
    @IBOutlet weak var checkBoxButton: PMSuperButton!
    
    @IBOutlet weak var loadingButton: PMSuperButton!
    @IBOutlet weak var tapToShowLoadingBlockButton: PMSuperButton!
    
    @IBOutlet weak var pushVCButton: PMSuperButton!
    
    @IBOutlet weak var checkBoxView: BEMCheckBox!
    @IBOutlet weak var checkLabel: UILabel!
    
    @IBOutlet weak var showBulletinBoardButton: PMSuperButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePastelView()
        configureButtons()
        configureBulletinBoards()
    }
    
    func configurePastelView() {
        let pastelView = PastelView(frame: view.bounds)
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        pastelView.animationDuration = 3.0
        pastelView.setColors([.red, .purple, .orange])
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }
    
    func configureButtons() {
        materialButton.enableRippleBehavior = true
        materialButton.inkStyle = .bounded
        materialButton.inkColor = .lightGray
        materialButton.setBackgroundColor(.white)
        materialButton.layer.cornerRadius = 10.0
        materialButton.setElevation(ShadowElevation(rawValue: 6.0), for: .normal)
        
        gradientView.layer.cornerRadius = 14.0
        gradientView.clipsToBounds = true
        
//        checkBoxButton.checkedImage = UIImage(named: "icons8-ok-75-filled")
//        checkBoxButton.uncheckedImage = UIImage(named: "icons8-ok-75")
        checkBoxButton.checkboxButton = true
        
        loadingButton.touchUpInside {
            self.loadingButton.showLoader(userInteraction: true)
            self.loadingButton.setTitle(nil, for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.loadingButton.hideLoader()
                self.loadingButton.setTitle("Loading button", for: .normal)
            }
        }
        
        tapToShowLoadingBlockButton.touchUpInside {
            let activityData = ActivityData(message: "Please wait...", type: .circleStrokeSpin)
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
        }
        
        pushVCButton.touchUpInside {
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroViewController") as! IntroViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        checkBoxView.delegate = self
        checkBoxView.onAnimationType = .bounce
        checkBoxView.offAnimationType = .bounce
        checkBoxView.onFillColor = .white
        checkBoxView.offFillColor = .clear
        checkBoxView.tintColor = .white
//        checkBoxView.onCheckColor = .clear
        
        checkLabel.text = "Check me!"
        
        showBulletinBoardButton.animatedScaleWhenHighlighted = 0.95
        showBulletinBoardButton.animatedScaleDurationWhenHighlighted = 0.25
        showBulletinBoardButton.touchUpInside {
            self.bulletinManager.showBulletin(above: self)
        }
    }
    
    func configureBulletinBoards() {
        namePageItem = TextFieldBulletinPage(title: "What's your name?")
        namePageItem.appearance.titleTextColor = .lightGray
        namePageItem.appearance.descriptionTextColor = .darkGray
        namePageItem.descriptionText = "Please enter your name in order to show it on your profile."
        
        namePageItem.actionButtonTitle = "Save"
        namePageItem.actionHandler = {  (item: BLTNActionItem) in
            self.namePageItem.manager?.dismissBulletin()
        }
        
        notificationsPageItem = BLTNPageItem(title: "Push Notifications")
        notificationsPageItem.appearance.titleTextColor = .lightGray
        notificationsPageItem.appearance.descriptionTextColor = .darkGray
        notificationsPageItem.image = UIImage(named: "icons8-notification")
        notificationsPageItem.descriptionText = "Receive push notifications when new updates are available."
        notificationsPageItem.actionButtonTitle = "Subscribe"
        notificationsPageItem.alternativeButtonTitle = "Not now"
        
        notificationsPageItem.next = namePageItem
        notificationsPageItem.actionHandler = { (item: BLTNActionItem) in
            self.notificationsPageItem.manager?.displayActivityIndicator(color: .darkGray)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.notificationsPageItem.manager?.hideActivityIndicator()
                self.notificationsPageItem.manager?.displayNextItem()
//                self.notificationsPageItem.manager?.push(item: self.namePageItem) // same as above
            }
        }
        notificationsPageItem.alternativeHandler = { (item: BLTNActionItem) in
            self.notificationsPageItem.manager?.dismissBulletin()
        }
        
        bulletinManager = BLTNItemManager(rootItem: notificationsPageItem)
        bulletinManager.backgroundViewStyle = .blurredLight
        bulletinManager.backgroundColor = .white
        
    }

}


extension ViewController: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        checkLabel.text = checkBox.on ? "Uncheck me!" : "Check me!"
    }
}
