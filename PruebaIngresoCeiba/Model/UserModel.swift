//
//  UserModel.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation
import RealmSwift

enum UserEndpoints: String {
    case getUsers = "/users"
}

typealias ModelCompletion = ( (_ response: Result<Any, TypeError>) -> Void )

class UserModel {
    
    var realmManager: RealmManager
    
    init(realmManager: RealmManager = RealmManager()) {
        self.realmManager = realmManager
    }
    
    func getUsersFromWS(completion: @escaping ModelCompletion) {
        Connection.sendRequest(endPoint: UserEndpoints.getUsers.rawValue) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let users = try JSONDecoder().decode([User].self, from: result)
                        completion(.success(users))
                    } catch let error {
                        print("Error while parsing the data: \(error.localizedDescription)")
                        completion(.failure(.internalError))
                    }
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
        
    }
    
    func fetchUsersFromLocalDB(completion: @escaping ModelCompletion) {
        let users = realmManager.getAllUsers()
        completion(.success(users))
        
    }
    
    func addUserToDB(_ user: User, completion: @escaping ModelCompletion) {
        let response = realmManager.addUser(user)
        if response {
            completion(.success("User added succesfully."))
        } else {
            completion(.success("Can`t add user."))
        }
    }
    
}
