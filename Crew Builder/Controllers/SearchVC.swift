//
//  SearchVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

class SearchVC: UIViewController {
    let logoImageView = UIImageView()
    let usernameTextField = CBTextField()
    let callToActionButton = CBButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListViewController() {
        guard isUsernameEntered else {
            presentCBAlertOnMainThread(title: "Empty Username", message: "Please enter a username.", buttonTitle: "Ok")
            return
        }
        
        // THIS IS WHERE THE SCREEN IS ANIMATED
        let personListVC = PersonListVC()
        personListVC.username = usernameTextField.text
        personListVC.title = usernameTextField.text
        navigationController?.pushViewController(personListVC, animated: true)
    }
    
    func configureLogoImageView() {
        // same as dragging element onto the storyboard
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        // think about putting this into a constant
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        // delegate is necessary so that the UITextFieldDelegate func knows what to listen for.
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        
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

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListViewController()
        return true
    }
}
