//
//  ItemDetailViewControllerTableViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 VercruysseMazet. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var listToEdit : Checklist!
    var delegate: ListDetailViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        if listToEdit != nil {
            textField.text = listToEdit?.name as String?
        }
        else {
            print("ADD")
        }
    }
    
    
    @IBAction func done(){
        if listToEdit != nil {
            listToEdit?.name = textField.text!
            delegate?.listDetailViewController(controller: self, didFinishEditingItem: listToEdit!)
        }
        else {
            delegate?.listDetailViewController(controller: self, didFinishAddingItem: Checklist(name: textField.text!))
        }
    }
    
    @IBAction func cancel(){
        delegate?.listDetailViewControllerDidCancel(controller: self)
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

protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist)
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingItem item: Checklist)
}
