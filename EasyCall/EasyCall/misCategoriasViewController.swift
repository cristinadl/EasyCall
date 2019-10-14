//
//  ViewController.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class misCategoriasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, protocoloAgregarCategoria {
    
    var categorias = [Categoria]()
    @IBOutlet weak var tableView: UITableView!
    
    func dataFileUrl() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Categoria.plist")
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
        //else{
            //let viewAgregar = segue.destination as! menuViewController
        //}
    }
    
    
    //MARK: - Métodos del protocolo Agregar Jugador
    func agregaCategoria(cat: Categoria) {
        categorias.append(cat)
        guardarCategoria()
        tableView.reloadData()
        
    }
    
    @IBAction func guardarCategoria() {
        
        print(categorias.count)
        do {
            let data = try PropertyListEncoder().encode(categorias)
            try data.write(to: dataFileUrl())
        }
        catch {
            print("Save Failed")
        }
    }
    
    @IBAction func obtenerCategorias() {
        // borro la lista para verificar que sí se obtengan
        categorias.removeAll()
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl())
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

extension UIViewController {
    
    
    @objc func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

