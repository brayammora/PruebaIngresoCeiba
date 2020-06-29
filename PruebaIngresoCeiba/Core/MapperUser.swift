//
//  MapperUser.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 29/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation
import RealmSwift

class MapperUser {
    
    static func mapToUserLocal(_ user: User) -> UserLocal {
        let userLocal = UserLocal()
        userLocal.id = user.id
        userLocal.name = user.name
        userLocal.phone = user.phone
        userLocal.email = user.email
        
        return userLocal
    }
    
    static func mapToUser(_ userLocal: UserLocal) -> User {
        let user = User(
            id: userLocal.id,
            name: userLocal.name,
            email: userLocal.email,
            phone: userLocal.phone
        )
        return user
    }
    
    static func mapRealmResultSetToArray(_ userLocalList: Results<UserLocal>) -> [User] {
        var userArray: [User] = []
        for userLocal in userLocalList {
            userArray.append(mapToUser(userLocal))
        }
        return userArray
    }
    
}
