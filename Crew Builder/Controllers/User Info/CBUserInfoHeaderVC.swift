//
//  CBUserInfoHeaderVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class CBUserInfoHeaderVC: UIViewController {

    let avatarImageView = CBAvatarImageView(frame: .zero)
    let usernameLabel = CBTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = CBSecondaryTitleLabel(fontSize: 18)
    let skillLabel = CBSkillLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(skillLabel)
    }
    
    func configureUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        configureSkillsLabel()
    }
    
    func configureSkillsLabel() {
        let skill = skillLabel.returnSkill(from: user.login.count)
        skillLabel.text = skill
        skillLabel.numberOfLines = 3
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            skillLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            skillLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            skillLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            skillLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

