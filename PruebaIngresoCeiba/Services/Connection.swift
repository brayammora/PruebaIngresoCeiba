//
//  Connection.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 28/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation
import Alamofire

typealias ConnectionResponse = ( (_ response: Result<Data, TypeError>) -> Void )

class Connection {

    static func sendRequest (endPoint: String, completion: @escaping ConnectionResponse) {
        let url = Constants.urlSecure + endPoint
        
        AF.request(url, method: .get).response { (response) in
            if let error = response.error {
                print("Can't get response from server: ", error.localizedDescription)
                completion(.failure(.requestError))
                return
            }
            
            if let response = response.response {
                if response.statusCode != 200 {
                    completion(.failure(.serverError))
                }
            }
            
            if let data = response.data {
                completion(.success(data))
            }
        }
    }
}
