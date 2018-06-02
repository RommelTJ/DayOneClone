//
//  PhotoCollectionViewController.swift
//  DayOneClone
//
//  Created by Rommel Rico on 5/30/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var pictures: Results<Picture>?
    
    override func viewWillAppear(_ animated: Bool) {
        getPictures()
    }
    
    func getPictures() {
        if let realm = try? Realm() {
            pictures = realm.objects(Picture.self)
            collectionView?.reloadData()
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let pictures = self.pictures {
            return pictures.count
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell {
            if let picture = pictures?[indexPath.row] {
                cell.previewImageView.image = picture.thumbnailImage()
                cell.dayLabel.text = picture.entry?.dayPrettyString()
                cell.monthYearLabel.text = picture.entry?.monthYearPrettyString()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "photoToDetailSegue", sender: pictures?[indexPath.row].entry)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoToDetailSegue" {
            if let entry = sender as? Entry {
                if let detailVC = segue.destination as? JournalDetailViewController {
                    detailVC.entry = entry
                }
            }
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/2)
    }
    
}
