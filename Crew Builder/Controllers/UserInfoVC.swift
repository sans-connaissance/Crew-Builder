//
//  UserInfoVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
    
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = CBBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: PersonListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissInfoViewController))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentCBAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        
//        let repoItemViewController = GFRepoItemViewController(user: user)
//        repoItemViewController.delegate = self
//
//        let followerItemViewController = GFFollowerItemViewController(user: user)
//        followerItemViewController.delegate = self
//
//
//        self.add(childVC: GCUserInfoHeaderViewController(user: user), to: self.headerView)
//        self.add(childVC: repoItemViewController, to: self.itemViewOne)
//        self.add(childVC: followerItemViewController, to: self.itemViewTwo)
//        self.dateLabel.text = "GitHub Since \(user.createdAt.convertToDisplayFormat())"
        
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //        itemViewOne.backgroundColor = .systemPink
        //        itemViewTwo.backgroundColor = .systemBlue
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissInfoViewController() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCBAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user is invalid", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }

    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentCBAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        delegate.didRequestPersons(for: user.login)
        dismissInfoViewController()
    }
}
