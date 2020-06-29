//
//  RealmManager.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 29/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    var realm: Realm!
    
    init() {
        do {
            realm = try Realm()
        } catch let error {
            print("Realm error: \(error.localizedDescription)")
        }
    }
    
    func getAllUsers () -> [User] {
        return MapperUser.mapRealmResultSetToArray(realm.objects(UserLocal.self))
    }
    
    func addUser(_ user: User) -> Bool{
        var result = false
        if !existsInDB(user.id) {
            self.insert(user)
            result = true
        }
        return result
    }
    
    func insert (_ user: User) {
        do {
            try realm.write {
                realm.add(MapperUser.mapToUserLocal(user))
            }
        } catch let error {
            print("Error insert Realm: \(error.localizedDescription)")
        }
    }
    
    func existsInDB(_ userId: Int) -> Bool {
        var exist = false
        let userLocal = realm.objects(UserLocal.self).filter("id == \(userId)")
        if userLocal.count > 0 {
            exist = true
        }
        return exist
    }
}
