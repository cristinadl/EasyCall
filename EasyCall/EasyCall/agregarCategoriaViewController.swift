//
//  agregarCategoriaViewController.swift
//  EasyCall
//
//  Created by Mm on 10/13/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

protocol protocoloAgregarCategoria {
    func agregaCategoria(cat : Categoria) -> Void
}

class agregarCategoriaViewController: UIViewController,UIPopoverPresentationControllerDelegate {
        
        var categorias = [Categoria]()
        
        @IBOutlet weak var nombreTextField: UITextField!
        @IBOutlet weak var iconTextField: UITextField!
        
        var delegado : protocoloAgregarCategoria!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "Agregar Categoria"
            
        }
        
        @IBAction func guardarCategoria(_ sender: UIButton) {
            if  let nom = nombreTextField.text,
                let img = iconTextField.text {
                
                let cat = Categoria(nombre: nom, icon: img)
                
                delegado.agregaCategoria(cat: cat)
                navigationController?.popViewController(animated: true)
            }
        }
        
        func adaptivePresentationStyle (for controller:
        UIPresentationController) -> UIModalPresentationStyle {
        return .none
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               let vistaPopOver = segue.destination as! PopOverViewController
           vistaPopOver.popoverPresentationController!.delegate = self
          // vistaPopOver.dato = lbMensaje.text
           
       }
}

