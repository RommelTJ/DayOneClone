//
//  CreateJournalViewController.swift
//  DayOneClone
//
//  Created by Rommel Rico on 5/30/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit
import RealmSwift

class CreateJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var journalTextView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var aboveNavBarView: UIView!
    
    private var date = Date()
    private var imagePicker = UIImagePickerController()
    private var images: [UIImage] = []
    var startWithCamera = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar customizations.
        navBar.barTintColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // 4CC1FC
        navBar.tintColor = .white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        aboveNavBarView.backgroundColor = UIColor(red: 0.298, green: 0.757, blue: 0.988, alpha: 1.00) // 4CC1FC
        
        // Keyboard Notification Observers.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        // Image Picker
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if startWithCamera {
            startWithCamera = false
            blueCameraTapped("")
        }
    }
    
    func updateDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        navBar.topItem?.title = formatter.string(from: date)
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
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let realm = try? Realm() {
            let entry = Entry()
            entry.text = journalTextView.text
            entry.date = date
            for image in images {
                let picture = Picture(image: image)
                entry.pictures.append(picture)
                picture.entry = entry
            }
            
            // Save to Realm
            try? realm.write {
                realm.add(entry)
            }
            
            // Dismiss this entry.
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func setDateTapped(_ sender: Any) {
        journalTextView.isHidden = false
        datePicker.isHidden = true
        setDateButton.isHidden = true
        date = datePicker.date
        updateDate()
    }
    
    @IBAction func blueCalendarTapped(_ sender: Any) {
        journalTextView.isHidden = true
        datePicker.isHidden = false
        setDateButton.isHidden = false
        datePicker.date = date
    }
    
    @IBAction func blueCameraTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Image Picker Delegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            images.append(chosenImage)
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imageView.image = chosenImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imagePicker.dismiss(animated: true) {
                // TODO: Add some animation.
            }
        }
    }
    
}
