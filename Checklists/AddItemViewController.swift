//
//  AddItemViewControllerTableViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 VercruysseMazet. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var itemToEdit : ChecklistItem?
    var delegate: AddItemViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        if itemToEdit != nil {
            textField.text = itemToEdit?.text
        }
        else {
            print("ADD")
        }
    }


    @IBAction func done(){
        if itemToEdit != nil {
            itemToEdit?.text = textField.text!
        delegate?.addItemViewController(controller: self, didFinishEditingItem: itemToEdit!)
        }
        else {
        delegate?.addItemViewController(controller: self, didFinishAddingItem: ChecklistItem(text: textField.text!))

        }
    }
    
    @IBAction func cancel(){
        delegate?.addItemViewControllerDidCancel(controller: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let beforeText: NSString = textField.text! as NSString
        let afterText: NSString = beforeText.replacingCharacters(in: range, with: string) as NSString
        
        if afterText.length > 0 {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
        
        return true
    }
    
    

}

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}


