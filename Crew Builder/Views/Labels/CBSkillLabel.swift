//
//  CBSkillLabel.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class CBSkillLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }

    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        sizeToFit()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func returnSkill(from bioCount: Int) -> String {
        switch bioCount {
        case 0...4:
            return "Digital Effects"
        case 5...7:
            return "Editor"
        case 8...9:
            return "Camera Operator"
        case 10...11:
            return "Sound Design"
        case 12...25:
            return "Director"
        case 26...100:
            return "Visionary"
        default:
            return "Production ASST."
        }
    }
}
