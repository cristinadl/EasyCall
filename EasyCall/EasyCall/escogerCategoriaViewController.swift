//
//  ViewController.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

protocol protocoloCambiar {
    func cambiarCategoria(cont : Contacto) -> Void
}
class escogerCategoriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var contacts = [Contacto]()
//    var filteredData = [Contacto]()
//    var isSearching = false
    
    var delegado : protocoloCambiar!
    var contactoSeleccionado : Contacto!
    
    @IBOutlet weak var tableView: UITableView!
    
    var categorias = [Categoria]()
    
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
        
        obtenerCategorias()
//        hideKeyboard()
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! categoriaCellTableViewCell
        
        cell.iconImage.image =  UIImage(named: categorias[indexPath.row].icon)
        cell.name.text = categorias[indexPath.row].nombre
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactoSeleccionado.categoria = categorias[indexPath.row].nombre
        contactoSeleccionado.icon = categorias[indexPath.row].icon
        delegado.cambiarCategoria(cont: contactoSeleccionado)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - Navigation
    

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
    
}
