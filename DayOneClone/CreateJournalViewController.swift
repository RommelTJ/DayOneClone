//
//  CreateJournalViewController.swift
//  DayOneClone
//
//  Created by Rommel Rico on 5/30/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

class CreateJournalViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var aboveNavBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.barTintColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // 4CC1FC
        navBar.tintColor = .white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        aboveNavBarView.backgroundColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // 4CC1FC
        
        // Keyboard Notification Observers.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navBar.topItem?.title = "June 1"
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        changeKeyboardHeight(notification: notification)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        changeKeyboardHeight(notification: notification)
    }
    
    func changeKeyboardHeight(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyHeight = keyboardFrame.cgRectValue.height
            bottomConstraint.constant = -keyHeight - 10
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
    }
    
    @IBAction func saveTapped(_ sender: Any) {
    }
    
    @IBAction func setDateTapped(_ sender: Any) {
    }
    
    @IBAction func blueCalendarTapped(_ sender: Any) {
    }
    
    @IBAction func blueCameraTapped(_ sender: Any) {
    }
    
}
