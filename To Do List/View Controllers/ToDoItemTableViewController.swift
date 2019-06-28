//
//  ToDoItemTableViewController.swift
//  To Do List
//
//  Created by Denis Bystruev on 21/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ToDoItemTableViewController: UITableViewController {
    // MARK: - Properties
    var todo = ToDo()
}

// MARK: - UITableViewDataSource
extension ToDoItemTableViewController/*: UITableViewDataSource*/ {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let value = todo.values[indexPath.section]
        if let cell = tableView.cellForRow(at: indexPath) {
            return cell.isHidden ? 0 : UITableView.automaticDimension
        } else {
            return value is Date && indexPath.row == 1 ? 0 : UITableView.automaticDimension
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return todo.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let value = todo.values[section]
        return value is Date ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let value = todo.values[section]
        let cell = getCellFor(indexPath: indexPath, with: value)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = todo.capitilizedKeys[section]
        return key
    }
}

// MARK: - Cell Configurator
extension ToDoItemTableViewController {
    func getCellFor(indexPath: IndexPath, with value: Any?) -> UITableViewCell {
        if let stringValue = value as? String {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            cell.textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textField.section = indexPath.section
            cell.textField.text = stringValue
            return cell
            
        } else if let dateValue = value as? Date {
            
            switch indexPath.row {
                
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
                cell.setDate(dateValue)
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! DatePickerCell
                cell.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
                cell.datePicker.date = dateValue
                cell.datePicker.section = indexPath.section
                cell.datePicker.minimumDate = Date()
                
                return cell
                
            default:
                fatalError("Please add more prototype cells for Date section")
                
            }
            
        } else if let imageValue = value as? UIImage? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            cell.largeImageView.image = imageValue
            return cell
            
        } else if let boolValue = value as? Bool {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.switch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            cell.switch.isOn = boolValue
            cell.switch.section = indexPath.section
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            cell.textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textField.section = indexPath.section
            cell.textField.text = ""
            return cell
            
        }
    }
}

// MARK: - Actions
extension ToDoItemTableViewController {
    @objc func datePickerValueChanged(_ sender: SectionDatePicker) {
        let section = sender.section!
        let key = todo.keys[section]
        let value = sender.date
        todo.setValue(value, forKey: key)
        let labelIndexPath = IndexPath(row: 0, section: section)
        tableView.reloadRows(at: [labelIndexPath], with: .automatic)
    }
    
    @objc func switchValueChanged(_ sender: SectionSwitch) {
        let key = todo.keys[sender.section!]
        let value = sender.isOn
        todo.setValue(value, forKey: key)
    }
    
    @objc func textFieldValueChanged(_ sender: SectionTextField) {
        let key = todo.keys[sender.section!]
        let text = sender.text ?? ""
        todo.setValue(text, forKey: key)
    }
}

// MARK: - UITableViewDelegate
extension ToDoItemTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datePickerIndexPath = IndexPath(row: 1, section: indexPath.section)
        guard let datePickerCell = tableView.cellForRow(at: datePickerIndexPath) as? DatePickerCell else { return }
        datePickerCell.isHidden.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
