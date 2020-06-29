//
//  UserViewController.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UserViewModelDelegate {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = UserViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureTableView()
        loadUsers()
        configureSearchBar()
        configureNavbar()
    }
    
    //MARK: UserViewModel Delegate
    func reloadTable() {
        tableView.reloadData()
        self.hideLoading()
    }

    private func loadUsers() {
        self.showLoading()
        viewModel.loadUsers()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: Constants.idUserCell)
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchPlaceHolder
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureNavbar() {
        self.navigationItem.title = Constants.userNavTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.userFiltered = viewModel.users.filter { (user: User) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.deselectSelectedRow(animated: true)
    }
}

//MARK: - TableViewDelegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let story = UIStoryboard(name: "Publication", bundle: nil)
        let viewController = story.instantiateViewController(withIdentifier: "PublicationViewController") as! PublicationViewController
        let userSelected = !isFiltering ? viewModel.users[indexPath.row] : viewModel.userFiltered[indexPath.row]
        viewController.viewModel.user = userSelected
        //UserDefaultsUtils.saveUser(userSelected)
        self.navigationController?.pushViewController(viewController, animated: true)

    }
}

//MARK: - TableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = !isFiltering ? viewModel.users.count : viewModel.userFiltered.count
        
        if count == 0 {
            tableView.setEmptyMessage(Constants.emptyListMessage)
        } else {
            tableView.restore()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idUserCell ) as! UserCell
        let user = !isFiltering ? viewModel.users[indexPath.row] : viewModel.userFiltered[indexPath.row]
        cell.configureCell(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(102.0)
    }
}

// MARK: - Extension of SearchController
extension UserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let searchText = searchBar.text {
            filterContentForSearchText(searchText)
        }
    }
}
