//
//  PublicationViewModel.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import Foundation

protocol PublicationViewModelDelegate: class {
    func reloadTable()
}

class PublicationViewModel {

    private let model: PublicationModel
    weak var delegate: PublicationViewModelDelegate?
    var user: User?
    var publications: [Publication] = []
    
    init(publicationModel: PublicationModel = PublicationModel()) {
        self.model = publicationModel
    }
    
    func getPublicationsByUser() {
        guard let userId = user?.id else { return }
        model.getPublicationsByUser(userId) { [weak self] response in
            guard let _ = self else {
                return
            }
            
            switch response {
                case .success(let result):
                    if let postsFromWS = result as? [Publication] {
                        self?.publications = postsFromWS
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
            self?.delegate?.reloadTable()
        }
    }
    
}
