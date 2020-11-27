//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import UIKit

class GFBodyLabel: UILabel {

    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    
    
    //MARK: Custom Init
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configureLabel()
    }
    
    
    //MARK: Configure Label
    private func configureLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
