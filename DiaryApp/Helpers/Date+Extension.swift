//
//  Date+Extension.swift
//  DiaryApp
//
//  Created by Michael Flowers on 1/28/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation

extension Date {
    func prettyDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}
