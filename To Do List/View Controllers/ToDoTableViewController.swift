//
//  ToDoTableViewController.swift
//  To Do List
//
//  Created by Denis Bystruev on 21/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var todos = [ToDo]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToDoItemSegue" else { return }
        guard let destination = segue.destination as? ToDoItemTableViewController else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
        destination.todo = todos[selectedIndex.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = [
            ToDo(title: "Купить молоко", image: UIImage(named: "milk")),
            ToDo(title: "Заехать в МФЦ", image: UIImage(named: "mfc")),
            ToDo(title: "Встретиться с инвесторами", image: UIImage(named: "investor"))
        ]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title
        cell.detailTextLabel?.text = todo.formattedDate
        cell.imageView?.image = todo.image
        return cell
    }
    
    // MARK: - Navigation
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue" else { return }
        let source = segue.source as! ToDoItemTableViewController
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
        todos[selectedIndex.row] = source.todo
        tableView.reloadRows(at: [selectedIndex], with: .automatic)
    }
}
