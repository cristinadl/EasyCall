//
//  categoriaCellTableViewCell.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class categoriaCellTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
