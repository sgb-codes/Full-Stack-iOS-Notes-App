//
//  ViewController.swift
//  FullStackNotes
//
//  Created by Simon Barrett on 28/08/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

protocol DataDelegate {
    func updateArray(newArray: String)
}

class ViewController: UIViewController {
    
    //MARK: - Outlets and Class Variables
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var notesArray = [Note]()
    
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate and Datasource Attached to Class
        notesTableView.delegate = self
        notesTableView.dataSource = self
        APIFunctions.functions.delegate = self
        
        APIFunctions.functions.fetchNotes()
    }
    
    //MARK: - Segue to Update Note
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "updateNoteSegue" {
            vc.navigationItem.title = "Update Note"
            vc.update = true
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
        }
    }
}

//MARK: - TableView Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        
        cell.titleLabel.text = notesArray[indexPath.row].title
        cell.noteLabel.text = notesArray[indexPath.row].note
        cell.dateLabel.text = notesArray[indexPath.row].date
        
        return cell
    }
    
    
}

//MARK: - Delegate Extension

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        do {
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
        } catch {
            print("Failed to decode!")
        }
        
        notesTableView.reloadData()
    }
    
    
}

