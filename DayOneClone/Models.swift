//
//  Models.swift
//  DayOneClone
//
//  Created by Rommel Rico on 6/1/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import Foundation
import RealmSwift

class Entry: Object {
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
    let pictures = List<Picture>()
}

class Picture: Object {
    @objc dynamic var fullImageName = ""
    @objc dynamic var thumbnailImage = ""
    @objc dynamic var entry: Entry?
}
