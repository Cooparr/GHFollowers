//
//  GFButton.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 27/11/2020.
//

import UIKit

class GFButton: UIButton {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    
    //MARK: Custom Init
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configureButton()
    }
    
    
    //MARK: Configure Button
    private func configureButton() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
