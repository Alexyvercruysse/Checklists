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
     var list: Checklist! 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //loadChecklistItems()
        checklistitem = list.items
        if let checkList = self.list {
            title = checkList.name
        }
    }
    
    override func awakeFromNib() {
        //loadChecklistItems()
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
                self.saveChecklistItems()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.checklistitem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            saveChecklistItems()
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
        (cell.viewWithTag(2) as? UILabel)?.text = item.text as String
    }

    @IBAction func addDummyTodo(_ sender: AnyObject) {
        checklistitem.append(ChecklistItem(text: "Dummy Dummy", checked: false))
        tableView.insertRows(at: [IndexPath(item: checklistitem.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        if segue.identifier == "AddItem",
            let destination = segue.destination as? UINavigationController,
            let vc = destination.topViewController as? ItemDetailViewController
        {
            vc.delegate = self
        }
        else if segue.identifier == "EditItem",
            let destination = segue.destination as? UINavigationController,
            let vc = destination.topViewController as? ItemDetailViewController
        {
            vc.delegate = self
            vc.itemToEdit = checklistitem[(tableView.indexPath(for: (sender as! UITableViewCell))?.row)!]
        }
    }
    
    func saveChecklistItems() {
        NSKeyedArchiver.archiveRootObject(checklistitem, toFile: dataFileUrl().path)
    }
    
    func loadChecklistItems() {
        checklistitem = NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().path) as! [ChecklistItem]
    }
    
    
    // MARK: FILE
    func documentDirectory() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
    }
    
    func dataFileUrl() -> URL{
        return documentDirectory().appendingPathComponent("Checklists.plist")
    }
    
    
}


// MARK: -
// MARK: Add Item View Controller Delegate
extension ChecklistViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        dismiss(animated: true, completion: nil)
        checklistitem.append(item)
        tableView.insertRows(at: [IndexPath(item: checklistitem.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        saveChecklistItems()
    }
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        dismiss(animated: true, completion: nil)
        print (checklistitem.index(where: { $0 === item }))
        tableView.reloadRows(at : [IndexPath(item: checklistitem.index(where: { $0 === item })!, section : 0)], with: UITableViewRowAnimation.automatic)
        
        saveChecklistItems()
    }

}

