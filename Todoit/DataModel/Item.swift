//
//  Item.swift
//  Todoit
//
//  Created by Nicole Blackwell on 6/29/18.
//  Copyright © 2018 Nicole Blackwell. All rights reserved.
//

import Foundation
import UIKit

//This file defines List Item class for the TodoIt App
//Must mark class as comforming to Encodable
//for class to be encodable, all properties must be std data types
class Item : Encodable {
    var title: String = ""
    var complete: Bool = false
}
