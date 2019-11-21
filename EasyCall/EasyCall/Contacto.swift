//
//  Contacto.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class Contacto: NSObject, Codable, NSCoding {

    var icon: String
    var nombre: String
    var apellido: String
    var number: String
    var emergencia: Bool
    var categoria: String
    
    init(nombre: String, apellido: String, number: String, icon: String, emergencia: Bool, categoria:String) {
        self.nombre = nombre
        self.apellido = apellido
        self.number = number
        self.icon = icon
        self.emergencia = emergencia
        self.categoria = categoria
    }
    
    func getNombreCompleto()->String{
        return nombre + " " + apellido
    }
    
    
    convenience required init(coder aDecoder: NSCoder) {
        let nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        let apellido = aDecoder.decodeObject(forKey: "apellido") as! String
        let number = aDecoder.decodeObject(forKey: "number") as! String
        let icon = aDecoder.decodeObject(forKey: "icon") as! String
        let emergencia = aDecoder.decodeObject(forKey: "emergencia") as! Bool
        let categoria = aDecoder.decodeObject(forKey: "categoria") as! String
        
        self.init(nombre: nombre, apellido: apellido, number:number, icon:icon, emergencia:emergencia, categoria:categoria)
    }
    
    func initWithCoder(coder aDecoder: NSCoder) -> Contacto {
        self.nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        self.number = aDecoder.decodeObject(forKey: "number") as! String
        self.icon = aDecoder.decodeObject(forKey: "icon") as! String
        self.emergencia = aDecoder.decodeObject(forKey: "emergencia") as! Bool
        self.categoria = aDecoder.decodeObject(forKey: "categoria") as! String
        
        return self
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: "nombre")
        aCoder.encode(number, forKey: "number")
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(emergencia, forKey: "emergencia")
        aCoder.encode(categoria, forKey: "categoria")
    }
    
    
}

