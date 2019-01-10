//
//  item.swift
//  ToDoey
//
//  Created by Tom Creaven on 10/01/2019.
//  Copyright © 2019 Tom Creaven. All rights reserved.
//

import Foundation

//inherits from encodable so all types must be standard types

class Item: Codable {
    
    
    var title: String = ""
    var done: Bool = false
}
