//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 02/12/2020.
//

import Foundation

extension Date {
    
    //MARK: ConvertToMonthYearFormat
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
