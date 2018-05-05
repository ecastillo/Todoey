//
//  Category.swift
//  Todoey
//
//  Created by Eric Castillo on 5/3/18.
//  Copyright © 2018 Eric Castillo. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
