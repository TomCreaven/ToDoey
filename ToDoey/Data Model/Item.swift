//
//  Item.swift
//  ToDoey
//
//  Created by Tom Creaven on 14/01/2019.
//  Copyright © 2019 Tom Creaven. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
