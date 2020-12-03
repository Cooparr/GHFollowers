//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    
    //MARK: Convenience Init
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    //MARK: Configure Label
    private func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
