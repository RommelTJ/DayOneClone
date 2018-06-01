//
//  JournalTableViewController.swift
//  DayOneClone
//
//  Created by Rommel Rico on 5/30/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

class JournalTableViewController: UITableViewController {

    @IBOutlet weak var whiteCameraButton: UIButton!
    @IBOutlet weak var whitePlusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        whiteCameraButton.imageView?.contentMode = .scaleAspectFit
        whitePlusButton.imageView?.contentMode = .scaleAspectFit
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNewSegue", sender: "camera")
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNewSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNewSegue" {
            if let text = sender as? String {
                if text == "camera" {
                    let createVC = segue.destination as? CreateJournalViewController
                    createVC?.startWithCamera = true
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
