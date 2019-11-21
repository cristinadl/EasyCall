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

class CategoriaViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var delegado : protocoloEliminarCategoria!
    
    @IBOutlet weak var tableView: UITableView!
    
    var nombreCat : String!
    var contacts = [Contacto]()
    var filteredContacts = [Contacto]()
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! categoriaCellTableViewCell
        
        cell.name.text = filteredContacts[indexPath.row].nombre
        cell.numeroCelular.text = filteredContacts[indexPath.row].number
        cell.iconImage.image = UIImage(named: filteredContacts[indexPath.row].icon)

        

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editarContactoSegue"){
            
        }
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
