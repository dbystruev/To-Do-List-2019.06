//
//  DateCell.swift
//  To Do List
//
//  Created by Denis Bystruev on 21/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    func setDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        label.text = formatter.string(from: date)
    }
}
