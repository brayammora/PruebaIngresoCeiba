//
//  PublicationViewController.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import UIKit

class PublicationViewController: UIViewController, PublicationViewModelDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = PublicationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureTableView()
        configureUserInformation()
        loadUserPublications()
        configureNavbar()
    }
    
    func reloadTable() {
        self.tableView.reloadData()
        self.hideLoading()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PublicationCell", bundle: nil), forCellReuseIdentifier: Constants.idPublicationCell)
    }
    
    private func configureUserInformation() {
        nameLabel.text = viewModel.user?.name
        phoneLabel.text = viewModel.user?.phone
        emailLabel.text = viewModel.user?.email
    }
    
    private func loadUserPublications() {
        self.showLoading()
        viewModel.getPublicationsByUser()
    }

    private func configureNavbar() {
        navigationItem.title = Constants.publicationNavTitle
    }
    
}

//MARK: - TableViewDelegate
extension PublicationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //nothing
    }
}

//MARK: - TableViewDataSource
extension PublicationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.publications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idPublicationCell) as! PublicationCell
        cell.configureCell(publication: viewModel.publications[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80.0)
    }
    
}
