//
//  DetailEntryViewController.swift
//  DiaryApp
//
//  Created by Michael Flowers on 1/28/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class DetailEntryViewController: UIViewController {

    var entryContrller: EntryController?
    var entry: Entry?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveProperties: UIBarButtonItem!
    @IBOutlet weak var deleteProperties: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
    }

}
