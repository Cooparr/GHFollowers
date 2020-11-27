//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 26/11/2020.
//

import UIKit

class SearchVC: UIViewController {

    //MARK: Properties
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let getFollowersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureFollowersButton()
    }

    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: Configure Logo ImageView
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
    }
    
    
    //MARK: Configure TextField
    private func configureTextField() {
        view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK: Configure Followers Button
    private func configureFollowersButton() {
        view.addSubview(getFollowersButton)
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            getFollowersButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            getFollowersButton.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor)
        ])
    }
}
