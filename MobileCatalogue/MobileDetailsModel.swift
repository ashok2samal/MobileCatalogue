//
//  MobileDetailsModel.swift
//  MobileCatalogue
//
//  Created by Ashok Samal on 07/06/18.
//  Copyright © 2018 Ashok Samal. All rights reserved.
//

import Foundation
import RealmSwift

class MobileDetailsModel: Object {
    @objc dynamic var name: String? = nil
    @objc dynamic var model: String? = nil
    @objc dynamic var color: String? = nil
    var cost = RealmOptional<Int>()
    var battery = RealmOptional<Int>()
    @objc dynamic var primaryCamera: String? = nil
    @objc dynamic var secondaryCamera: String? = nil
    @objc dynamic var memory: String? = nil
}
