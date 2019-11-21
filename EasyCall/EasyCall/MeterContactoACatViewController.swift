//
//  MeterContactoACatViewController.swift
//  EasyCall
//
//  Created by Mm on 11/8/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit
import CoreData
import Contacts

class MeterContactoACatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate, protocoloCambiar {
    
    
    var contacts = [Contacto]()
    var filteredData = [Contacto]()
    var isSearching = false
    var contactStore = CNContactStore()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        obtenerContactos()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        title = "Meter Contacto a Categoria"
        searchBar.placeholder = "Escribe aqui al Contacto que buscas"
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
        
        //print(self.contacts[0].getNombreCompleto() + " " + self.contacts[0].categoria + " " + self.contacts[0].number)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text == nil || searchBar.text == ""){
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filteredData = contacts.compactMap({ $0 }).filter{ $0.getNombreCompleto().prefix(searchText.count) == searchText }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! meterContactoTableViewCell
        
        if(isSearching){
            cell.contacto = contacts[indexPath.row]
            cell.name.text = filteredData[indexPath.row].getNombreCompleto()
            if(filteredData[indexPath.row].categoria == ""){
                cell.asignarCategoria.titleLabel?.text = "Asignar"
                cell.categoria.text = "Sin categoria"
                cell.iconImage.backgroundColor = UIColor.groupTableViewBackground
                cell.iconImage.image = UIImage()
                cell.iconImage.layer.cornerRadius = cell.iconImage.frame.height / 2
                
            }else{
                cell.asignarCategoria.titleLabel?.text = "Cambiar"
                cell.categoria.text = filteredData[indexPath.row].categoria
                cell.iconImage.backgroundColor = UIColor.white
                cell.iconImage.image = UIImage(named: contacts[indexPath.row].icon)
            }
        }else{
            
            cell.contacto = contacts[indexPath.row]
            
            cell.name.text = contacts[indexPath.row].getNombreCompleto()
            if(contacts[indexPath.row].categoria == ""){
                cell.asignarCategoria.titleLabel?.text = "Asignar"
                cell.categoria.text = "Sin categoria"
                cell.iconImage.backgroundColor = UIColor.groupTableViewBackground
                cell.iconImage.image = UIImage()
                cell.iconImage.layer.cornerRadius = cell.iconImage.frame.height / 2
            }else{
                cell.asignarCategoria.titleLabel?.text = "Cambiar"
                cell.categoria.text = contacts[indexPath.row].categoria
                cell.iconImage.backgroundColor = UIColor.white
                cell.iconImage.image = UIImage(named: contacts[indexPath.row].icon)
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewCambiar = segue.destination as! escogerCategoriaViewController
        viewCambiar.delegado = self
        viewCambiar.contactoSeleccionado = contactoAcambiar
    }
    
    func cambiarCategoria(cont: Contacto) {
        for contact in contacts{
            if(contact.getNombreCompleto() == cont.getNombreCompleto() && contact.number == cont.number){
                contact.categoria = cont.categoria
                contact.icon = cont.icon
            }
        }
        guardarContactos()
        tableView.reloadData()
    }
    
    
    
    
}
