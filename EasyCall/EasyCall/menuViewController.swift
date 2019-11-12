//
//  menuViewController.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class menuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    
//    func dataFileUrl() -> URL {
//        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//        let pathArchivo = url.appendingPathComponent("Categoria.plist")
//        return pathArchivo
//    }
    
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
        return 151
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
        
        
         performSegue(withIdentifier: segueToGo, sender: nil)
    }
    
    // meterContactoACatSegue
    // buscarSegue
    // agregarSegue
    
    
    
    
//    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let viewAgregar = segue.destination as! agregarCategoriaViewController
//        viewAgregar.delegado = self
//    }
//
//
//    //MARK: - Métodos del protocolo Agregar Jugador
//    func agregaCategoria(cat: Categoria) {
//        categorias.append(cat)
//        guardarCategoria()
//        tableView.reloadData()
//
//    }
//
//    @IBAction func guardarCategoria() {
//
//        print(categorias.count)
//        do {
//            let data = try PropertyListEncoder().encode(categorias)
//            try data.write(to: dataFileUrl())
//        }
//        catch {
//            print("Save Failed")
//        }
//    }
//
//    @IBAction func obtenerCategorias() {
//        // borro la lista para verificar que sí se obtengan
//        categorias.removeAll()
//
//        do {
//            let data = try Data.init(contentsOf: dataFileUrl())
//            categorias = try PropertyListDecoder().decode([Categoria].self, from: data)
//        }
//        catch {
//            print("Error reading or decoding file")
//        }
//
//        for cat in categorias {
//            print (cat.nombre, cat.icon)
//        }
//    }


}
