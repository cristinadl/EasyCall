//
//  llamarEmergenciaViewController.swift
//  EasyCall
//
//  Created by Mm on 11/20/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit
import CoreData
import Contacts

class llamarEmergenciaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var contacts = [Contacto]()
    var contactsEmergencia = [Contacto]()
    var contactStore = CNContactStore()
    
    var emergencia = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        obtenerContactos()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("regresando a la pantalla")
        //        print("no. emergencia = \(contactsEmergencia.count)")
        //        tableView.reloadData()
        //        obtenerContactos()
    }
    
    
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
    }
    
    @IBAction func editarPressed(_ sender: Any) {
        performSegue(withIdentifier: "ContactoEmergencia", sender: nil)
    }
    
    @IBAction func guardarContactos() {
        
        do {
            let data = try PropertyListEncoder().encode(contacts)
            try data.write(to: dataFileUrl(namePlist: "Contactos"))
        }
        catch {
            print("Save Failed")
        }
    }
    
    @IBAction func obtenerContactos() {
        // borro la lista para verificar que sí se obtengan
        contacts.removeAll()
        contactsEmergencia.removeAll()
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl(namePlist: "Contactos"))
            contacts = try PropertyListDecoder().decode([Contacto].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        
        for cont in contacts {
            if(cont.emergencia){
                contactsEmergencia.append(cont)
            }
        }
        tableView.reloadData()
        guardarContactos()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsEmergencia.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! contactTableViewCell
        
        let name = contactsEmergencia[indexPath.row].nombre
        
        cell.nombreLabel.text = name
        
        cell.numeroLabel.text = contactsEmergencia[indexPath.row].number
        
        
        if(contactsEmergencia[indexPath.row].icon == ""){
            cell.iconImage.backgroundColor = UIColor.init(red:0/255, green: 191/255, blue: 214/255, alpha: 1)
            
        }else{
            cell.iconImage.image = UIImage(named: contactsEmergencia[indexPath.row].icon)
        }
        
        cell.iconImage.layer.cornerRadius = cell.iconImage.frame.width / 2
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

