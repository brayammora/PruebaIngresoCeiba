//
//  UserCell.swift
//  PruebaIngresoCeiba
//
//  Created by Brayam Alberto Mora Arias on 27/06/20.
//  Copyright © 2020 Brayam Alberto Mora Arias. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell (user: User) {
        self.nameLabel.text = user.name
        self.phoneLabel.text = user.phone
        self.emailLabel.text = user.email
    }
}
