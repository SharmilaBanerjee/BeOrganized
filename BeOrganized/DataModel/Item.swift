//
//  Item.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 04/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var createdDate : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
