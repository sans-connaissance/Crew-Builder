//
//  CBTabBarController.swift
//  Crew Builder
//
//  Created by David Malicke on 6/23/22.
//

import UIKit

class CBTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = .systemPurple
        tabBar.tintColor = .systemPurple
        tabBar.backgroundColor = .systemBackground
        tabBar.isTranslucent = true
        tabBar.unselectedItemTintColor = .lightGray
        viewControllers = [createSearchNavigationController(), createCrewNavigationController()]
 
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Home"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createCrewNavigationController() -> UINavigationController {
        let crewVC = CrewListVC()
        crewVC.title = "Your Crew"
        crewVC.tabBarItem.title = "Your Crew"
        crewVC.tabBarItem.image = UIImage(systemName: "person.3.fill")
        crewVC.tabBarItem.tag = 1
        return UINavigationController(rootViewController: crewVC)
    }
}
