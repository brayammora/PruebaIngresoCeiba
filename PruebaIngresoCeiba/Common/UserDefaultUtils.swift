//
//  UserDefaultUtils.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 28/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

struct UserDefaultsUtils {
    
    fileprivate static var ud: UserDefaults {
        return UserDefaults.init()
    }

    /** User **/
    static func saveUser(_ user: User) {
        ud.set(try? PropertyListEncoder().encode(user), forKey: "user")
        ud.synchronize()
    }
    
    static func getUser() -> User? {
        if let data = ud.object(forKey: "user") as? Data {
            do{
                return try PropertyListDecoder().decode(User.self, from: data)
            }catch let error {
                print(error)
                return nil
            }
        }
        return nil
    }
    /** End **/

}
