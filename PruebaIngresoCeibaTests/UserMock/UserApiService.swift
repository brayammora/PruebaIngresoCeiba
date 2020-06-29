//
//  UserApiService.swift
//  PruebaIngresoCeibaTests
//
//  Created by Brayam Alberto Mora Arias on 29/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation
@testable import PruebaIngresoCeiba


class UserApiService: UserModel {
    
    var completion: ModelCompletion!
    
    override func getUsersFromWS(completion: @escaping ModelCompletion) {
        self.completion = completion
    }
    
    func fetchSuccess(_ users: [User]) {
        completion(.success(users))
    }
    
    func fetchFail(error: TypeError) {
        completion(.failure(error))
    }
}
