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
    
    
    //MARK: Custom Init
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configureLabel()
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
