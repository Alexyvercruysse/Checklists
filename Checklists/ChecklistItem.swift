//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 VercruysseMazet. All rights reserved.
//

import Foundation

public class ChecklistItem {
    var text: String
    var checked: Bool
    
    init(text : String, checked : Bool = false) {
        self.text = text
        self.checked = checked
    }
    
}
