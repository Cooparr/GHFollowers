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
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUserNameEntered: Bool {
        return !(usernameTextField.text?.isEmpty ?? false)
    }
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, getFollowersButton)
        configureLogoImageView()
        configureTextField()
        configureFollowersButton()
        createDismissKeyboardTapGesture()
    }

    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    //MARK: Create Dismiss Keyboard Tap Gesture
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    //MARK: Push Follower List VC
    @objc private func pushFollowerListVC() {
        guard isUserNameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for. \n🤔", buttonTitle: "Ok 👍")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowersListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    //MARK: Configure Logo ImageView
    private func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        
        NSLayoutConstraint.activate([
            logoImageViewTopConstraint,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
    }
    
    
    //MARK: Configure TextField
    private func configureTextField() {
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK: Configure Followers Button
    private func configureFollowersButton() {
        getFollowersButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            getFollowersButton.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            getFollowersButton.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor)
        ])
    }
}

extension SearchVC: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
