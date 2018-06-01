//
//  Models.swift
//  DayOneClone
//
//  Created by Rommel Rico on 6/1/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import Foundation
import RealmSwift
import Toucan

class Entry: Object {
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
    let pictures = List<Picture>()
}

class Picture: Object {
    @objc dynamic var fullImageName = ""
    @objc dynamic var thumbnailImage = ""
    @objc dynamic var entry: Entry?
    
    convenience init(image: UIImage) {
        self.init()
        
        // Save image to disk.
        fullImageName = imageToURLString(image: image)
        if let smallImage = Toucan(image: image).resize(CGSize(width: 500, height: 500), fitMode: .crop).image {
            thumbnailImage = imageToURLString(image: smallImage)
        }
    }
    
    func imageToURLString(image: UIImage) -> String {
        if let imageData = UIImagePNGRepresentation(image) {
            let fileName = UUID().uuidString + ".png"
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            path.appendPathComponent(fileName)
            try? imageData.write(to: path)
            return fileName
        }
        return ""
    }
}
