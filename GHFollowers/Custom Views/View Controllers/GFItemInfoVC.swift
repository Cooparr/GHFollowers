//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import UIKit

class GFItemInfoVC: UIViewController {

    //MARK: Properties
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    
    //MARK: Configure Background View
    fileprivate func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    //MARK: Layout UI
    fileprivate func layoutUI() {
        view.addSubviews(stackView, actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    //MARK: Configure Stack View
    fileprivate func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
}
