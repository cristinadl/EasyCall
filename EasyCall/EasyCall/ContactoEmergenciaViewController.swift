//
//  ContactoEmergenciaViewController.swift
//  EasyCall
//
//  Created by Martha Arnaud on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit
import CoreData
import Contacts

protocol protocoloContactoEmergencia {
    func contactoEmergencia(cat : Categoria) -> Void
}

class ContactoEmergenciaViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var contacts = [Contacto]()
    var filteredData = [Contacto]()
    var isSearching = false
    var contactStore = CNContactStore()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func btLlamar(_ sender: UIButton) {
       
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
        obtenerContactos()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text == nil || searchBar.text == ""){
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filteredData = contacts.compactMap({ $0 }).filter{ $0.nombre.prefix(searchText.count) == searchText }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching){
            return filteredData.count
        }
        
//        print("number of sections \(contacts.count)")
        return contacts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! contactTableViewCell
        
        if(isSearching){
            let name = filteredData[indexPath.row].nombre
            
            
            cell.nombreLabel.text = filteredData[indexPath.row].nombre
            
            cell.numeroLabel.text = filteredData[indexPath.row].number
            
            if(filteredData[indexPath.row].icon == ""){
                cell.iconImage.backgroundColor = UIColor.init(red:0/255, green: 191/255, blue: 214/255, alpha: 1)
            }else{
                //                print(contacts[indexPath.section][indexPath.row])
                cell.iconImage.image = UIImage(named: filteredData[indexPath.row].icon)
            }
            
            
            if(filteredData[indexPath.row].emergencia){
                cell.emergenciaButton.backgroundColor = UIColor(red: 51/255, green: 190/255, blue: 255/255, alpha: 1)
                cell.emergenciaButton.setTitle("Agregar", for: .normal)
            }else{
                cell.emergenciaButton.backgroundColor = UIColor(red: 51/255, green: 190/255, blue: 119/255, alpha: 1)
                cell.emergenciaButton.setTitle("Agregado", for: .normal)
            }
            
        }else{
            
            let name = contacts[indexPath.row].nombre
            
            cell.nombreLabel.text = name
            
            cell.numeroLabel.text = contacts[indexPath.row].number
            
            if(contacts[indexPath.row].icon == ""){
                cell.iconImage.backgroundColor = UIColor.init(red:0/255, green: 191/255, blue: 214/255, alpha: 1)
            }else{
                cell.iconImage.image = UIImage(named: contacts[indexPath.row].icon)
            }
            
            if(contacts[indexPath.row].emergencia){
                cell.emergenciaButton.backgroundColor = UIColor(red: 51/255, green: 190/255, blue: 119/255, alpha: 1)
                cell.emergenciaButton.setTitle("Agregado", for: .normal)
                
            }else{
                cell.emergenciaButton.backgroundColor = UIColor(red: 51/255, green: 190/255, blue: 255/255, alpha: 1)
                cell.emergenciaButton.setTitle("Agregar", for: .normal)
            }
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
