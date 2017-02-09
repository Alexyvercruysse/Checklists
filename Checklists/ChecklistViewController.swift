//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 VercruysseMazet. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var checklistitem = [ChecklistItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        checklistitem.append(ChecklistItem(text: "Mettre à jour XCode"))
        checklistitem.append(ChecklistItem(text: "Devenir un bon codeur"))
        checklistitem.append(ChecklistItem(text: "Devenir beau"))
        checklistitem.append(ChecklistItem(text: "Comprendre le swift"))
        checklistitem.append(ChecklistItem(text: "Rafraichir le PDF"))
        checklistitem.append(ChecklistItem(text: "Frapper son voisin"))
        checklistitem.append(ChecklistItem(text: "ETEINDRE CE MAC DE *****"))
        checklistitem.append(ChecklistItem(text: "Empecher le voisin de copier", checked: true))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return checklistitem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for:
            indexPath)
        configureTextFor(cell: cell, withItem: checklistitem[indexPath.row])
        configureCheckmarkFor(cell: cell, withItem: checklistitem[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        checklistitem[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (checklistitem[indexPath.row].checked == true){
            let alert = UIAlertController(title: "Not Finish", message: "This task is not finish, would you delete it anyway ?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.destructive, handler: { action in
                self.checklistitem.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.checklistitem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
        
    }
    
    func configureCheckmarkFor(cell: UITableViewCell, withItem item: ChecklistItem){
        if item.checked {
            cell.viewWithTag(1)?.isHidden = true
        }
        else {
            cell.viewWithTag(1)?.isHidden = false
        }
    }
    
    func configureTextFor(cell: UITableViewCell, withItem item: ChecklistItem){
        (cell.viewWithTag(2) as? UILabel)?.text = item.text
    }

    @IBAction func addDummyTodo(_ sender: AnyObject) {
        checklistitem.append(ChecklistItem(text: "Dummy Dummy", checked: false))
        tableView.insertRows(at: [IndexPath(item: checklistitem.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        if segue.identifier == "AddItem",
            let destination = segue.destination as? UINavigationController,
            let vc = destination.topViewController as? AddItemViewController
        {
            vc.delegate = self
        }
        else if segue.identifier == "EditItem",
            let destination = segue.destination as? UINavigationController,
            let vc = destination.topViewController as? AddItemViewController
        {
            vc.delegate = self
            vc.itemToEdit = checklistitem[(tableView.indexPath(for: (sender as! UITableViewCell))?.row)!]
        }
    }
}


// MARK: -
// MARK: Add Item View Controller Delegate
extension ChecklistViewController: AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
    }
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        dismiss(animated: true, completion: nil)
        checklistitem.append(item)
        tableView.insertRows(at: [IndexPath(item: checklistitem.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
    }
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem) {
        dismiss(animated: true, completion: nil)
        print (checklistitem.index(where: { $0 === item }))
        tableView.reloadRows(at : [IndexPath(item: checklistitem.index(where: { $0 === item })!, section : 0)], with: UITableViewRowAnimation.automatic)
        
        
    }

}

