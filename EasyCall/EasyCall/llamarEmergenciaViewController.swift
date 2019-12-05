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
    
    var emergencia = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    var contacts = [Contacto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contactos Emergencia"
        obtenerContactos()
        getContactoEmergencia()
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("regresando a la pantalla")
        print("no. emergencia = \(contactosEmergencia.count)")
        tableView.reloadData()
    }
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
    }
    
    @IBAction func guardarContactos() {
        
        print(contacts.count)
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
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl(namePlist: "Contactos"))
            contacts = try PropertyListDecoder().decode([Contacto].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        guardarContactos()
        
    }
    
    func getContactoEmergencia(){
        contactosEmergencia = [Contacto]()
        for cont in contacts{
            if (cont.emergencia){
                contactosEmergencia.append(cont)
            }
        }
    }
    
    
    @IBAction func editarPressed(_ sender: Any) {
        performSegue(withIdentifier: "ContactoEmergencia", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactosEmergencia.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! contactTableViewCell
        
        let name = contactosEmergencia[indexPath.row].getNombreCompleto()
        
        cell.nombreLabel.text = name
        
        cell.numeroLabel.text = contactosEmergencia[indexPath.row].number
        
        
        if(contactosEmergencia[indexPath.row].categoria == "Sin Categoria" || contactosEmergencia[indexPath.row].icon == ""){
            cell.iconImage.image = UIImage()
            cell.iconImage.backgroundColor = UIColor.groupTableViewBackground
            cell.iconImage.layer.cornerRadius = cell.iconImage.frame.width / 2
            
        }else{
            cell.iconImage.backgroundColor = UIColor.white
            cell.iconImage.image = UIImage(named: contactosEmergencia[indexPath.row].icon)
            cell.iconImage.contentMode = .scaleAspectFit
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
}

