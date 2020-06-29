//
//  Constants.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

struct Constants {

    // MARK: connection
    static let networkProtocol: String = "https://"
    static let domain: String = "jsonplaceholder.typicode.com"
    static let urlSecure: String = Constants.networkProtocol + Constants.domain
    
    // MARK: user messages
    static let idUserCell = "userCell"
    static let userNavTitle = "Users"
    
    // MARK: publications messages
    static let idPublicationCell = "publicationCell"
    static let publicationNavTitle = "Publications"
    
    static let emptyListMessage = "List is empty"
    static let errorGetUsersDB = "Cannot get users"
    static let searchPlaceHolder = "Search"
}
