//
//  UserDataBuilder.swift
//  PruebaIngresoCeibaTests
//
//  Created by Brayam Alberto Mora Arias on 29/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation
@testable import PruebaIngresoCeiba

public class UserDataBuilder {
    
    var id: Int
    var name: String
    var email: String
    var phone: String
    
    init() {
        self.id = 0
        self.name = "Default Value"
        self.email = "Default Value"
        self.phone = "Default Value"
    }
    func withId (_ id: Int) {
        self.id = id
    }
    func withtName (_ name: String) {
        self.name = name
    }
    func withEmail (_ email: String) {
        self.email = email
    }
    func witPhone (_ phone: String) {
        self.phone = phone
    }
    func build () -> User {
        return User(id: id, name: name, email: email, phone: phone)
    }
    
}
