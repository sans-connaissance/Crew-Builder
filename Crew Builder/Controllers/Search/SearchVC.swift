//
//  SearchVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView = UIImageView()
    let onboardingBodyLabel = CBBodyLabel()
    let callToActionButton = CBButton(backgroundColor: .systemPurple, title: "Search")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureBodyLabel()
        configureCallToActionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 280),
            logoImageView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureBodyLabel() {
        view.addSubview(onboardingBodyLabel)
        onboardingBodyLabel.textAlignment = .center
        onboardingBodyLabel.text = "Find skilled production professionals in your area with Crew Builder Search."
        
        NSLayoutConstraint.activate([
            onboardingBodyLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            onboardingBodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            onboardingBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            onboardingBodyLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushPersonListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushPersonListVC() {
        let personListVC = PersonListVC()
        personListVC.username = "sallen0400"
        personListVC.title = "Pros Near You"
        navigationController?.pushViewController(personListVC, animated: true)
    }
}
