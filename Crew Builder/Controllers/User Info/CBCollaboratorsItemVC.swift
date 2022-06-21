//
//  CBCollaboratorsItemVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class CBCollaboratorsItemVC: CBItemForInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewTwo.set(itemInfoType: .collaborators, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "View Collaborators")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
