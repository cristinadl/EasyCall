//
//  ViewController.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class escogerCategoriaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var contacts = [Contacto]()
//    var filteredData = [Contacto]()
//    var isSearching = false
    
    
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
        return 151
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("quiero esta categoria = \(categorias[indexPath.row])")
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "agregarCategoria"){
//            let viewAgregar = segue.destination as! agregarCategoriaViewController
////            viewAgregar.delegado = self
//        }
//        if(segue.identifier == "contactosCategoria"){
//            let viewCategoria = segue.destination as! CategoriaViewController
////            viewCategoria.delegado = self
//            let indice = tableView.indexPathForSelectedRow!
//            viewCategoria.nombreCat = categorias[indice.row].nombre
//        }
//        //else{
//        //let viewAgregar = segue.destination as! menuViewController
//        //}
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
    
}
