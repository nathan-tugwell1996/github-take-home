//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Nathan Tugwell on 23/08/2022.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
