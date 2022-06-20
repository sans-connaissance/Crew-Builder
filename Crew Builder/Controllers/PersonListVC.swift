//
//  PersonListVC.swift
//  Crew Builder
//
//  Created by David Malicke on 6/20/22.
//

import UIKit

protocol PersonListVCDelegate: AnyObject {
    func didRequestPersons(for username: String)
}

class PersonListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var persons: [Person] = []
    var filteredPersons: [Person] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Person>!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getPersons(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        //initialize object
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        //use object
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Refine your search"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
    }
    
    func getPersons(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getPersons(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let persons):
                if persons.count < 100 {
                    self.hasMoreFollowers = false }
                self.persons.append(contentsOf: persons)
                
                if self.persons.isEmpty {
                    let message = "This user doesn't have any followers. Follow them."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        return
                    }
                }
                self.updateData(on: self.persons)
            case .failure(let error):
                self.presentCBAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Person>(collectionView: collectionView, cellProvider: { collectionView, indexPath, person -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.reuseID, for: indexPath) as! PersonCollectionViewCell
            cell.set(person: person)
            return cell
        })
    }
    
    func updateData(on followers: [Person]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Person>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favorite = Person(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else {return}
                    
                    guard let error = error else {
                        self.presentCBAlertOnMainThread(title: "Success!", message: "This person is now in your crew.", buttonTitle: "Congrats!")
                        return
                    }
                    self.presentCBAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
            case .failure(let error):
                self.presentCBAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}
//nice to use an extension each time you conform to a new protocol
extension PersonListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offSetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getPersons(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray = isSearching ? filteredPersons : persons
        let follower = activeArray[indexPath.item]
        let destinationViewController = UserInfoVC()
        destinationViewController.username = follower.login
        destinationViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        present(navigationController, animated: true)
    }
}

extension PersonListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        isSearching = true
        filteredPersons = persons.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredPersons)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: persons)
    }
}

extension PersonListVC: PersonListVCDelegate {
    func didRequestPersons(for username: String) {
        self.username = username
        title = username
        page = 1
        persons.removeAll()
        filteredPersons.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getPersons(username: username, page: page)
        
    }
}
