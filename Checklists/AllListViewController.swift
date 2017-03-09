//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 VercruysseMazet. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    var checkLists = [Checklist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLists.append(Checklist(name : "Liste 1", items:[ChecklistItem(text: "Element liste 1")]))
        
        tableView.insertRows(at: [IndexPath(row: checkLists.count-1, section: 0)], with: .automatic)
        checkLists.append(Checklist(name : "Liste 2", items:[ChecklistItem(text: "Element liste 2")]))
        
        tableView.insertRows(at: [IndexPath(row: checkLists.count-1, section: 0)], with: .automatic)
        
        checkLists.append(Checklist(name : "Liste 3", items:[ChecklistItem(text: "Element liste 3")]))
        
        tableView.insertRows(at: [IndexPath(row: checkLists.count-1, section: 0)], with: .automatic)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return checkLists.count;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Checklist", for: indexPath)
        configureTextForCell(cell: cell, withItem: checkLists[indexPath.row])
        return cell;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            checkLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    func configureTextForCell(cell: UITableViewCell, withItem item: Checklist){
        cell.textLabel?.text = item.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToList" {
            let cvc  = segue.destination as! ChecklistViewController;
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                cvc.list = checkLists[indexPath.row]
            }
        }
        if segue.identifier == "AddList",
            let destination = segue.destination as? UINavigationController,
            let vc = destination.topViewController as? ListDetailViewController
        {
            vc.delegate = self
        }
        else if segue.identifier == "EditList",
            let destination = segue.destination as? UINavigationController,
            let vc = destination.topViewController as? ListDetailViewController
        {
            vc.delegate = self
            vc.listToEdit = checkLists[(tableView.indexPath(for: (sender as! UITableViewCell))?.row)!]
        }

    }
    

    
}

extension AllListViewController: ListDetailViewControllerDelegate {
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem item: Checklist) {
        dismiss(animated: true, completion: nil)
        checkLists.append(item)
        tableView.insertRows(at: [IndexPath(item: checkLists.count-1, section: 0)], with: UITableViewRowAnimation.automatic)
        //saveChecklistItems()
    }
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingItem item: Checklist) {
        dismiss(animated: true, completion: nil)
        print (checkLists.index(where: { $0 === item }))
        tableView.reloadRows(at : [IndexPath(item: checkLists.index(where: { $0 === item })!, section : 0)], with: UITableViewRowAnimation.automatic)
        
        //saveChecklistItems()
    }
    
}
