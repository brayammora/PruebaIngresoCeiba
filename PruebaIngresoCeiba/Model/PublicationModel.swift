//
//  PublicationModel.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

enum PublicationEndpoints: String {
    case getPostsByUser = "/posts?userId="
}

class PublicationModel {
    
    func getPublicationsByUser(_ userId: Int, completion: @escaping ModelCompletion) {
        let endpoint = PublicationEndpoints.getPostsByUser.rawValue + "\(userId)"
        Connection.sendRequest(endPoint: endpoint) { (response) in
            switch response {
                case .success(let result):
                    do {
                        let publications = try JSONDecoder().decode([Publication].self, from: result)
                        completion(.success(publications))
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
    
}
