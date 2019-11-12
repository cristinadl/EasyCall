//
//  meterContactoTableViewCell.swift
//  EasyCall
//
//  Created by Mm on 11/11/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit
protocol protocoloCambiarCategoria {
    func cambiarCategoria(cat : Categoria) -> Void
}

class meterContactoTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var categoria: UILabel!
    @IBOutlet weak var asignarCategoria: UIButton!
    
    var num : String!
    
    var delegado : protocoloCambiarCategoria!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cambiarCategoria(_ sender: UIButton){
        
    }
    
    

}
