//
//  EntryListTableViewController.swift
//  DiaryApp
//
//  Created by Michael Flowers on 1/28/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit
import CoreData

class EntryListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.fetchedResultsController.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return EntryController.shared.fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry  = EntryController.shared.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = entry.name
        cell.detailTextLabel?.text = entry.timestamp?.prettyDate()
        // Configure the cell...

        return cell
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             let entry = EntryController.shared.fetchedResultsController.object(at: indexPath)
            EntryController.shared.delete(entry: entry)
            
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellSegue" {
            guard let destinationVC = segue.destination as? DetailEntryViewController, let indexPath =  tableView.indexPathForSelectedRow else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
            let entry = EntryController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.entry = entry
        }
    }
}

extension EntryListTableViewController: NSFetchedResultsControllerDelegate {
    //will tell the tableViewController get ready to do something.
       func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           tableView.beginUpdates()
       }
       
       func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           tableView.endUpdates()
       }
       
       func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                       didChange anObject: Any,
                       at indexPath: IndexPath?,
                       for type: NSFetchedResultsChangeType,
                       newIndexPath: IndexPath?) {
           switch type {
           case .insert:
               //there was a new entry so now we need to make a new cell.
               guard let newIndexPath = newIndexPath else {return}
               tableView.insertRows(at: [newIndexPath], with: .automatic)
           case .delete:
               guard let indexPath = indexPath else {return}
               tableView.deleteRows(at: [indexPath], with: .fade)
           case .move:
               guard let indexPath = indexPath, let newIndexpath = newIndexPath else {return}
               tableView.moveRow(at: indexPath, to: newIndexpath)
           case .update:
               guard let indexPath = indexPath else {return}
               tableView.reloadRows(at: [indexPath], with: .automatic)
           @unknown default:
            fatalError()
        }
           
       }
       
       func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
               switch type {
           case .insert:
               let indexSet = IndexSet(integer: sectionIndex)
                   tableView.insertSections(indexSet, with: .automatic)
           case .delete:
               let indexSSet = IndexSet(integer: sectionIndex)
               tableView.deleteSections(indexSSet, with: .automatic)
           default:
               break
           }
       }
}
