//
//  UserLocal.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 29/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation
import RealmSwift

class UserLocal: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
}
