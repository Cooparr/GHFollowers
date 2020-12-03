//
//  View+Ext.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import UIKit

extension UIView {
    
    //MARK: Add Subviews
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}

