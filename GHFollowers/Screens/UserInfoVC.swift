//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Alexander James Cooper on 01/12/2020.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {

    //MARK: Properties
    var username: String!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    weak var delegate: UserInfoVCDelegate!
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    
    //MARK: Configure VC
    fileprivate func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    //MARK: Configure Scroll View
    fileprivate func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.pinToEdges(of: view)
        
        scrollView.addSubview(contentView)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 620)
        ])
    }
    
    
    
    //MARK: Get user Info
    fileprivate func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
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
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
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
