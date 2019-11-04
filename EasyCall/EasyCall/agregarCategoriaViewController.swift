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
        
//        var categorias = [Categoria]()
        
        @IBOutlet weak var nombreTextField: UITextField!
        @IBOutlet weak var iconTextField: UITextField!
   
    @IBOutlet weak var imagesView: UIView!
    var imagen: UIImage!
    @IBOutlet weak var iconImageView: UIImageView!
    
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
    
    @IBAction func selectedIcon(_ sender: Any) {
        imagesView.isHidden = false
    }
    @IBAction func selectIcon(_ sender: UIButton) {
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
        
        func adaptivePresentationStyle (for controller:
        UIPresentationController) -> UIModalPresentationStyle {
        return .none
        }
    
    func actualizarDato(img: UIImage){
        iconImageView.image = img
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               let vistaPopOver = segue.destination as! PopOverViewController
           vistaPopOver.popoverPresentationController!.delegate = self
        vistaPopOver.imagen = iconImageView.image
           
       }
}

