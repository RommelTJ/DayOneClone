//
//  JournalTableViewController.swift
//  DayOneClone
//
//  Created by Rommel Rico on 5/30/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit
import RealmSwift

class JournalTableViewController: UITableViewController {

    @IBOutlet weak var whiteCameraButton: UIButton!
    @IBOutlet weak var whitePlusButton: UIButton!
    private var entries: Results<Entry>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whiteCameraButton.imageView?.contentMode = .scaleAspectFit
        whitePlusButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEntries()
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNewSegue", sender: "camera")
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNewSegue", sender: nil)
    }
    
    func getEntries() {
        if let realm = try? Realm() {
            entries = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        }
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
