//
//  ViewController.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit
import CoreData
import Contacts

class misCategoriasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, protocoloAgregarCategoria, protocoloEliminarCategoria, UIPopoverPresentationControllerDelegate {
    var contacts = [Contacto]()
    var filteredData = [Contacto]()
    var isSearching = false
    var contactStore = CNContactStore()
    
    var usuarioNuevo = true
    
   
    
    
    var categorias = [Categoria]()
    @IBOutlet weak var tableView: UITableView!
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return categorias.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mis Categorias"
        obtenerContactos()
        obtenerCategorias()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if let new = defaults.value(forKey: "nuevo") as? Bool {
            usuarioNuevo = new
        }
        
        if(usuarioNuevo){
            crearCategoriasDefault()
            contactStore.requestAccess(for: .contacts, completionHandler: { (success,error) in
                if success {
                    print("Contact Authorization Succesfully")
                }
                
            })
            fetchContacts()
            cleanContacts()
        }
    }
    
    func cleanContacts(){
        for contact in contacts{
            if(contact.number != ""){
                let num = String(contact.number.digits.suffix(10))
                contact.number = num
            }
            guardarContactos()
        }
    }
    
    func crearCategoriasDefault(){
        categorias += [Categoria(nombre: "Familia", icon: "6"), Categoria(nombre: "Amigos", icon: "1"), Categoria(nombre: "Amigos del café", icon: "5"),Categoria(nombre: "Servicios de emergencia", icon: "2"), Categoria(nombre: "Servicios generales", icon: "4"), Categoria(nombre: "Servicios varios", icon: "9")]
        guardarCategoria()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! categoriaCellTableViewCell
        
        cell.iconImage.image =  UIImage(named: categorias[indexPath.row].icon)
        cell.name.text = categorias[indexPath.row].nombre

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 151
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "agregarCategoria"){
            let viewAgregar = segue.destination as! agregarCategoriaViewController
            viewAgregar.delegado = self
        }
        if(segue.identifier == "contactosCategoria"){
            let viewCategoria = segue.destination as! CategoriaViewController
            viewCategoria.delegado = self
            let indice = tableView.indexPathForSelectedRow!
            viewCategoria.nombreCat = categorias[indice.row].nombre
        }
        
                
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                let vistaPopOver = segue.destination as! PopOverCreditosViewController
//            vistaPopOver.popoverPresentationController!.delegate = self
//            //vistaPopOver.dato = lbMensaje.text
//            
//        }
    
    @IBAction func contactoEmergenciaClick(_ sender: UIButton) {
        obtenerContactos()
        var count = 0
        for cont in contacts {
            if(cont.emergencia){
                count = count + 1
             
                print(cont.nombre)
            }
        }
        
        if(count > 0){
            print("hay \(count) contactos de emergencia")
          performSegue(withIdentifier: "llamarEmergencia", sender: nil)
        }else{
            print("no hay contactos de emergencia")
            performSegue(withIdentifier: "ContactoEmergencia", sender: nil)
        }
    }
    
    //MARK: - Métodos del protocolo Agregar Jugador
    func agregaCategoria(cat: Categoria) {
        for categoria in categorias{
            if(categoria.nombre == cat.nombre){
                let alert = UIAlertController(title: "Ese nombre de categoría ya existe", message: "Intente de nuevo con otro nombre", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Button", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        categorias.append(cat)
        guardarCategoria()
        tableView.reloadData()
    }
    
    func eliminarCategoria(cat: Categoria) {
        obtenerContactos()
        var rem = -1
        var i = 0
        
        for cont in contacts{
            if(cont.categoria == cat.nombre){
                cont.categoria = "Sin Categoria"
                cont.icon = ""
            }
        }
        for categoria in categorias {
            if(categoria.nombre == cat.nombre){
                rem = i
            }
            i += 1
        }
        
        guardarContactos()
        if(rem >= 0){
            categorias.remove(at: rem)
            guardarCategoria()
            tableView.reloadData()
        }
    }
    
    
    @IBAction func guardarCategoria() {
        
        print(categorias.count)
        do {
            let data = try PropertyListEncoder().encode(categorias)
            try data.write(to: dataFileUrl(namePlist: "Categoria"))
        }
        catch {
            print("Save Failed")
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
    
    @IBAction func obtenerCategorias() {
        // borro la lista para verificar que sí se obtengan
        categorias.removeAll()
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl(namePlist: "Categoria"))
            categorias = try PropertyListDecoder().decode([Categoria].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        for cat in categorias {
            print (cat.nombre, cat.icon)
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
        
        //print(self.contacts[0].nombre + " " + self.contacts[0].categoria + " " + self.contacts[0].number)
        
    }
    
    func fetchContacts(){
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try! contactStore.enumerateContacts(with: request) {(contact, stoppingPointer) in
            
            let name = contact.givenName
            let familyName = contact.familyName
            var number = ""
            if(contact.phoneNumbers != []){
                number = (contact.phoneNumbers.first?.value.stringValue)!
            }
            
            let contactToAppend = Contacto(nombre: name, apellido: familyName, number: number, icon: "", emergencia: false, categoria: "")
            
            self.contacts.append(contactToAppend)
            let defaults = UserDefaults.standard
            
            defaults.set(false, forKey: "nuevo")
            self.guardarContactos()
            
        }
    }
    


}

extension UIViewController {
    
    
    @objc func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

