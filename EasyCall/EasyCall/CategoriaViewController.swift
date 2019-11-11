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
