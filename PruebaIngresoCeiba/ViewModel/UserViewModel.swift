//
//  UserViewModel.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

protocol UserViewModelDelegate: class {
    func reloadTable()
}

class UserViewModel {
    
    private let model: UserModel
    weak var delegate: UserViewModelDelegate?
    var users: [User] = []
    var userFiltered: [User] = []
    
    init(userModel: UserModel = UserModel()) {
        self.model = userModel
        
    }
    
    func loadUsers() {
        model.fetchUsersFromLocalDB() { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
                case .success(let result):
                    if let usersFromDB = result as? [User] {
                        if usersFromDB.count > 0 {
                            self?.users = usersFromDB
                            self?.delegate?.reloadTable()
                        } else {
                            self?.getUsers()
                        }
                        
                    }
                break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
        
    }
    
    func getUsers() {
        model.getUsersFromWS() { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
                case .success(let result):
                    if let usersFromWS = result as? [User] {
                        for user in usersFromWS {
                            self?.addUserToDB(user)
                        }
                        self?.users = usersFromWS
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
            self?.delegate?.reloadTable()
        }
    }
    
    func addUserToDB(_ user: User) {
        model.addUserToDB(user) { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
                case .success(let result):
                    if let result = result as? String {
                        print(result)
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
    }
}
