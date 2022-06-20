//
//  ProfileItemVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class ProfileItemVC: CBItemForInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    

    private func configureItems() {
//        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
//        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
//        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
