//
//  categoriaCellTableViewCell.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

protocol pasarInformacion {
    func pasandoInfo(from cell: categoriaCellTableViewCell)
}

class categoriaCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numeroCelular: UILabel!
    @IBOutlet weak var llamarContacto: UIButton!
    @IBOutlet weak var editarContacto: UIButton!
    
    var delegado : pasarInformacion!
    
    var onButtonTapped: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func callContact(number: String){
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func llamandoAContacto(_ sender: Any) {
        callContact(number: (numeroCelular.text?.digits)!)
        //        print("llamando a \(name.text) con numero: \(numeroCelular.text)")
    }
    
    @IBAction func editandoAContacto(_ sender: UIButton) {
        print("passing data")
        self.delegado?.pasandoInfo(from: self)
    }
    
    
}
