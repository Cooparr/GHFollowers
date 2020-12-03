//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 03/12/2020.
//

import UIKit

extension UITableView {
    
    //MARK: Reload Data On Main Thread
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    //MARK: Remove Excess Cells
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
