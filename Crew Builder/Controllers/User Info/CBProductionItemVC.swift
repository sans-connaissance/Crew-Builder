//
//  CBProductionItemVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class CBProductionItemVC: CBItemForInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    

    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .production, withCount: user.publicRepos)
        actionButton.set(backgroundColor: .systemPurple, title: "Add To Crew")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
