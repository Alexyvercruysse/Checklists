
//  Checklist.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 VercruysseMazet. All rights reserved.
//

import UIKit

import UIKit

class Checklist: NSObject , NSCoding {
    
    var name : String
    var items : [ChecklistItem]
    
    
    init( name: String,items: [ChecklistItem] = [] ){
        self.name = name
        self.items = items
    }
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "text") as? String ?? ""
        self.items = (decoder.decodeObject(forKey: "items") as? [ChecklistItem])!
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.items, forKey: "items")
        
    }
    
}
