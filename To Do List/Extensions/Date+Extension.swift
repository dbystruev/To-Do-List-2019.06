//
//  Date+Extension.swift
//  To Do List
//
//  Created by Denis Bystruev on 28/06/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
