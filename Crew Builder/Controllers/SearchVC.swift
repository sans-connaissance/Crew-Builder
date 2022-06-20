//
//  SearchVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView = UIImageView()
    let onboardingTitleLabel = CBTitleLabel()
    let onboardingBodyLabel = CBBodyLabel()
    let callToActionButton = CBButton(backgroundColor: .systemPurple, title: "Search")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTitleLabel()
        configureBodyLabel()
        configureCallToActionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func pushFollowerListViewController() {
        let personListVC = PersonListVC()
        personListVC.username = "sallen0400"
        personListVC.title = "Pros Near You"
        navigationController?.pushViewController(personListVC, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTitleLabel() {
        view.addSubview(onboardingTitleLabel)
        // delegate is necessary so that the UITextFieldDelegate func knows what to listen for.
        onboardingTitleLabel.textAlignment = .center
        onboardingTitleLabel.text = "Build Your Crew"
        
        NSLayoutConstraint.activate([
            onboardingTitleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            onboardingTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            onboardingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            onboardingTitleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureBodyLabel() {
        view.addSubview(onboardingBodyLabel)
        // delegate is necessary so that the UITextFieldDelegate func knows what to listen for.
        onboardingBodyLabel.textAlignment = .center
        onboardingBodyLabel.text = "Find skilled production professionals in your area with Crew Builder Search."
        
        NSLayoutConstraint.activate([
            onboardingBodyLabel.topAnchor.constraint(equalTo: onboardingTitleLabel.bottomAnchor, constant: 40),
            onboardingBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            onboardingBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            onboardingBodyLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
