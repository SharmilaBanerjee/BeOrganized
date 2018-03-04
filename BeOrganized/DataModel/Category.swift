//
//  Category.swift
//  BeOrganized
//
//  Created by Sharmila Banerjee on 04/03/18.
//  Copyright © 2018 Sharmila Banerjee. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
