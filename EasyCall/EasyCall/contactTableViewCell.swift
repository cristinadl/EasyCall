//
//  contactTableViewCell.swift
//  EasyCall
//
//  Created by Mm on 10/14/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class contactTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var numeroLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var callButton: UIButton!
//    var botonAgregar: UIButton!
    
    
    
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
    
    @IBAction func callPressed(_ sender: Any) {
        callContact(number: (numeroLabel.text?.digits)!)
    }
    
    @IBAction func EmergenciaPressed(_ sender: Any) {
        // aqui pones que es contacto de emergenecia
        
        
    }
    
    

}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
