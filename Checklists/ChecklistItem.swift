//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 VercruysseMazet. All rights reserved.
//

import Foundation

public class ChecklistItem : NSObject, NSCoding {


    var text: NSString
    var checked: Bool
    
    init(text : String, checked : Bool = false) {
        self.text = text as NSString
        self.checked = checked
    }
    
    func toggleChecked (){
        self.checked = !self.checked
    }
    
    required convenience public init?(coder decoder: NSCoder) {
        guard let text = decoder.decodeObject(forKey: "text") as? String
            else { return nil }
        let checked = decoder.decodeBool(forKey: "checked")
        
        self.init(
            text: text,
            checked: checked
        )
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.checked, forKey: "checked")
    }


    
}

public func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
    return (lhs.text == rhs.text)
}
