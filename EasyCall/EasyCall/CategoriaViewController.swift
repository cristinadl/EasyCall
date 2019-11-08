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

class CategoriaViewController: UIViewController {
    
    var delegado : protocoloEliminarCategoria!
    
    var nombreCat : String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = nombreCat
        // ola k ase

        // Do any additional setup after loading the view.
    }
    
    @IBAction func eliminarCategoria(_ sender: UIButton) {
        let cat = Categoria(nombre: nombreCat, icon: "cafe")
        
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
