//
//  AddNoteViewController.swift
//  FullStackNotes
//
//  Created by Simon Barrett on 28/08/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    //MARK: - Outlets and Class Variables
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var note: Note?
    var update = false
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if update == true {
            titleTextField.text = note?.title
            bodyTextView.text = note?.note
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        if update == true {
            // Update Note
            APIFunctions.functions.updateNote(title: titleTextField.text!, note: bodyTextView.text!, date: date, id: note!._id)
            self.navigationController?.popViewController(animated: true)
            
        } else if titleTextField.text != "" && bodyTextView.text != "" {
            // Add New Note
            APIFunctions.functions.AddNote(title: titleTextField.text!, note: bodyTextView.text!, date: date)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        
        APIFunctions.functions.deleteNote(id: note!._id)
        
        self.navigationController?.popViewController(animated: true)
    }
}
