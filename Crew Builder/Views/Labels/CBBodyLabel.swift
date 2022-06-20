//
//  CBBodyLabel.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class CBBodyLabel: UILabel {
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
}
