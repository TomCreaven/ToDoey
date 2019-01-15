//
//  Category.swift
//  ToDoey
//
//  Created by Tom Creaven on 14/01/2019.
//  Copyright © 2019 Tom Creaven. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}
