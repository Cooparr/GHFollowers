//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {

    //MARK: Properties
    var username: String!
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    weak var delegate: UserInfoVCDelegate!
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    
    //MARK: Configure VC
    fileprivate func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    //MARK: Get user Info
    fileprivate func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    //MARK: Configure UI Elements
    fileprivate func configureUIElements(with user: User) {
        self.addChildVC(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.addChildVC(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.addChildVC(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    //MARK: Layout UI
    fileprivate func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        let itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK: Add Child VC
    fileprivate func addChildVC(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    
    //MARK: Dismiss View Controller
    @objc fileprivate func dismissVC() {
        dismiss(animated: true)
    }
}


extension UserInfoVC: GFRepoItemVCDelegate {
    
    //MARK: Did Tap GitHub Profile
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlURL) else {
            presentGFAlertOnMainThread(title: "Invalid URL",
                                       message: "The url attached to this user is invalid. 😔",
                                       buttonTitle: "Ok.")
            return
        }
        presentSafariVC(with: url)
    }
}


extension UserInfoVC: GFFollowerItemVCDelegate {
    
    //MARK: Did Tap Get Followers
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers",
                                       message: "This user has no followers. You could follow them? 😔",
                                       buttonTitle: "Ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.username)
        dismissVC()
    }
}
