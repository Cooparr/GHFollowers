//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 02/12/2020.
//

import Foundation

extension String {
    
    /*
     These functions aren't needed when using JSONDecoder.dateDecodingStrategy = .iso8601
     Due to recieving Date type when decoding, no longer need to conver from:
     String -> Date -> String
     */
    
    //MARK: Convert To Date
    fileprivate func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    
    //MARK: Convert To Display Format
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
