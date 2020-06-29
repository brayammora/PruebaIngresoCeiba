//
//  UserTests.swift
//  PruebaIngresoCeibaTests
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import XCTest
@testable import PruebaIngresoCeiba

class UserTests: XCTestCase {

    var userDataBuilder: UserDataBuilder!
    var userApiService: UserApiService!
    var userViewModel: UserViewModel!

    override func setUp() {
        super.setUp()
        userDataBuilder = UserDataBuilder()
        userApiService = UserApiService()
        userViewModel = UserViewModel(userModel: userApiService!)
    }
    
    override func tearDown() {
        userDataBuilder = nil
        userApiService = nil
        userViewModel = nil
        super.tearDown()
    }
    
    func test_getUsersWithSuccessfulResponseWithZeroUsers() {
        let users: [User] = []
        userViewModel.getUsers()
        userApiService.fetchSuccess(users)
        XCTAssertTrue(userViewModel.users.count == 0)
    }
    
    func test_getUsersWithSuccessfulResponseWithSomeUsers() {
        let users = loadUsers()
        userViewModel.getUsers()
        userApiService.fetchSuccess(users)
        XCTAssertTrue(userViewModel.users.count > 0)
    }
    
    func test_getUsersWithFailedResponseWithInternalError() {
        userViewModel.getUsers()
        userApiService.fetchFail(error: .internalError)
        XCTAssertEqual(userViewModel.messageError, "A error ocurred, try later")
    }
    
    func test_getUsersWithFailedResponseWithServerError() {
        userViewModel.getUsers()
        userApiService.fetchFail(error: .serverError)
        XCTAssertEqual(userViewModel.messageError, "Can't connect with server, please check internet connection.")
    }
    
    func test_getUsersWithFailedResponseWithRequestError() {
        userViewModel.getUsers()
        userApiService.fetchFail(error: .requestError)
        XCTAssertEqual(userViewModel.messageError, "Please contact with admin")
    }
    
    private func loadUsers() -> [User] {
        var users: [User] = []
        for _ in 0...10 {
            users.append(userDataBuilder.build())
        }
        return users
    }
    
}
