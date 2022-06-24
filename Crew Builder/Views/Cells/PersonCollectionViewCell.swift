//
//  PersonCell.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    static let reuseID = "PersonCell"
    let usernameLabel = CBTitleLabel(textAlignment: .center, fontSize: 16)
    let avatarImageView = CBAvatarImageView(frame: .zero)
    let skillLabel = CBSkillLabel(textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(person: Person) {
        usernameLabel.text = person.login
        NetworkManager.shared.downloadImage(from: person.avatarUrl) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
        let skill = skillLabel.returnSkill(from: person.login.count)
        skillLabel.text = skill
    }

    private func configure() {
        addSubview(usernameLabel)
        addSubview(avatarImageView)
        addSubview(skillLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20),
        
            avatarImageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            skillLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 2),
            skillLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            skillLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            skillLabel.heightAnchor.constraint(equalToConstant: 20),
            

            
            
        ])
    }
    
}
