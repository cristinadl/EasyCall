//
//  menuViewController.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class menuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categorias = [Categoria]()

    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerCategorias()
        
        title = "Menú"
        // Do any additional setup after loading the view.
    }
    
    var segueToGo: String = ""
    
    var menuItems: [menuItem] = [
        menuItem(nombre: "Agregar Contacto", icon: "agregarContacto"),
        menuItem(nombre: "Buscar Contacto", icon: "buscarContacto"),
        menuItem(nombre: "Meter un Contacto en una Categoria", icon: "meterContactoEnCategoria"),
//        menuItem(nombre: "Agregar mi lista de Contactos", icon: "agregarMiLista")
    ]
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! categoriaCellTableViewCell
        
        cell.iconImage.image = UIImage(named: menuItems[indexPath.row].icon)
        cell.name.text = menuItems[indexPath.row].nombre
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(menuItems[indexPath.row].nombre == "Agregar Contacto"){
            segueToGo = "agregarSegue"
        }
        
        if(menuItems[indexPath.row].nombre == "Buscar Contacto"){
            segueToGo = "buscarSegue"
        }
        if(menuItems[indexPath.row].nombre == "Meter un Contacto en una Categoria"){
            segueToGo =
            "meterContactoACatSegue"
            
        }
        
//        if(menuItems[indexPath.row].nombre == "Agregar mi lista de Contactos"){
//            segueToGo = ""
//        }
        
        
        if(segueToGo == "agregarSegue" && categorias.count == 0){
            let dialogMessage = UIAlertController(title: "NO HAY CATEGORÍAS", message: "Agrega una Categoría e intenta nuevamente.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
               
            })
            

            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
        }else if(segueToGo == "meterContactoACatSegue" && categorias.count == 0){
            let dialogMessage = UIAlertController(title: "NO HAY CATEGORÍAS", message: "Agrega una Categoría e intenta nuevamente.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
               
            })
            

            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: segueToGo, sender: nil)
        }
        
        
        
            
    }
    
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
 

}
