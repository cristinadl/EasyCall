//
//  Contacto.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class Contacto: NSObject, NSCoding {

    var icon: String
    var nombre: String
    var number: String
    
    init(nombre: String, number: String, icon: String) {
        self.nombre = nombre
        self.number = number
        self.icon = icon
    }
    
    
    convenience required init(coder aDecoder: NSCoder) {
        let nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        let number = aDecoder.decodeObject(forKey: "number") as! String
        let icon = aDecoder.decodeObject(forKey: "icon") as! String
        
        self.init(nombre: nombre, number:number, icon:icon)
    }
    
    func initWithCoder(coder aDecoder: NSCoder) -> Contacto {
        self.nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        self.number = aDecoder.decodeObject(forKey: "number") as! String
        self.icon = aDecoder.decodeObject(forKey: "icon") as! String
        
        return self
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: "nombre")
        aCoder.encode(number, forKey: "number")
        aCoder.encode(icon, forKey: "icon")
    }
    
    
}
