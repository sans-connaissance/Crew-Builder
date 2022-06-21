//
//  CrewListCell.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class CrewListCell: UITableViewCell {

    static let reuseID = "CrewListCell"
    let avatarImageView = CBAvatarImageView(frame: .zero)
    let usernameLabel = CBTitleLabel(textAlignment: .left, fontSize: 26)
    let skillLabel = CBSkillLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(newMember: Person) {
        usernameLabel.text = newMember.login
        avatarImageView.downloadImage(from: newMember.avatarUrl)
        let skill = skillLabel.returnSkill(from: newMember.login.count)
        skillLabel.text = skill
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(skillLabel)
        
        accessoryType = .none
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 35),
            
            skillLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            skillLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            skillLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            skillLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
