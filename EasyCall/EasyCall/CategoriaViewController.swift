//
//  CategoriaViewController.swift
//  EasyCall
//
//  Created by Cristina De León on 11/3/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

protocol protocoloEliminarCategoria {
    func eliminarCategoria(cat : Categoria) -> Void
}

var contacts2 = [Contacto]()

class CategoriaViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, protocoloEditarContacto {
    
    
    var delegado : protocoloEliminarCategoria!
    
    @IBOutlet weak var tableView: UITableView!
    
    var nombreCat : String!
    var contacts = [Contacto]()
    var filteredContacts = [Contacto]()
    
    var nombre: String?
    var apellido: String?
    var numero: String?
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
    }
    
    func reloadData(){
        guardarContactos()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerContactos()
        title = nombreCat
        filtrarContactos()
        
    }
    
    func filtrarContactos(){
        for contact in contacts {
            if(contact.categoria == nombreCat){
                filteredContacts.append(contact)
            }
        }
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
        
        contacts.removeAll()
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl(namePlist: "Contactos"))
            contacts = try PropertyListDecoder().decode([Contacto].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    var numCat = 0
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! categoriaCellTableViewCell
        
        cell.name.text = filteredContacts[indexPath.row].getNombreCompleto()
        cell.numeroCelular.text = filteredContacts[indexPath.row].number
        cell.iconImage.image = UIImage(named: filteredContacts[indexPath.row].icon)
        cell.iconImage.contentMode = .scaleAspectFit
        cell.apellido = filteredContacts[indexPath.row].apellido
        cell.nombre = filteredContacts[indexPath.row].nombre
        cell.delegado = self
        numCat = indexPath.row
        
        return cell
    }
    
    
    
    @IBAction func eliminarCategoria(_ sender: UIButton) {
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "¿QUIERES ELIMINARLA?", message: "¿Estas seguro que quieres eliminar la categoría? Una vez eliminada los contactos no tendrán categoría", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "SI", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.eliminar()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "NO", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
        
    }
    
    func eliminar(){
        let cat = Categoria(nombre: nombreCat, icon: "hospital")
        
        delegado.eliminarCategoria(cat: cat)
        navigationController?.popViewController(animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "editarContactoSegue"){
            let vc = segue.destination as! editarContactoViewController
            print("prepare segue entrado")
            vc.nombre = nombre!
            vc.apellido = apellido!
            vc.numero = numero!
            vc.delegado = self
            vc.categoria = nombreCat
            vc.numCategory = numCat
        }
        
    }
    

    
    func eliminarContacto(contOriginal: Contacto) {
        var count = 0
        var deleteAt = 0
        for cont in contacts {
            if(cont.number == contOriginal.number){
                deleteAt = count
            }
            count = count + 1
        }
        contacts.remove(at: deleteAt)
        reloadData()
        
    }
    
    func actualizarDato(contOriginal: Contacto, cont: Contacto) {
        for contact in contacts {
            if(contOriginal.number == contact.number){
                print("lo encontro")
                contact.nombre = cont.nombre
                contact.apellido = cont.apellido
                contact.categoria = cont.categoria
                contact.number = cont.number
                contact.icon = cont.icon
            }
        }
        reloadData()
    }
    
}
extension CategoriaViewController: pasarInformacion {
    func pasandoInfo(from cell: categoriaCellTableViewCell) {
        nombre = cell.nombre!
        apellido = cell.apellido!
        numero = cell.numeroCelular.text!
        
        //        self.performSegue(withIdentifier: "editarContactoSegue", sender: self)
        print("segue entrado")
    }
    
    
}

