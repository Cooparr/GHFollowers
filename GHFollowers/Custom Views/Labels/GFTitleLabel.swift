//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import UIKit

class GFTitleLabel: UILabel {

    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    
    //MARK: Convenience Init
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    //MARK: Configure Label
    private func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
