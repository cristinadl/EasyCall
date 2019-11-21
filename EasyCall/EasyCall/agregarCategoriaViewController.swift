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

class agregarCategoriaViewController: UIViewController, UIPopoverPresentationControllerDelegate{
        
    @IBOutlet weak var imagesView: UIView!
    //        var categorias = [Categoria]()
        
        @IBOutlet weak var nombreTextField: UITextField!
        @IBOutlet weak var iconTextField: UITextField!
   
    var imagen: String!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var delegado : protocoloAgregarCategoria!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            imagesView.isHidden = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
            title = "Agregar Categoria"
           
        }
    
    override func dismissKeyboard() {
        view.endEditing(true)
    }
        
        @IBAction func guardarCategoria(_ sender: UIButton) {
            if  let nom = nombreTextField.text,
                
                let img = imagen {
                
                let cat = Categoria(nombre: nom, icon: img)
                
                delegado.agregaCategoria(cat: cat)
                navigationController?.popViewController(animated: true)
            }
        }
        
        func adaptivePresentationStyle (for controller:
        UIPresentationController) -> UIModalPresentationStyle {
        return .none
        }
    
    func actualizarDato(img: UIImage){
        iconImageView.image = img
    }
    
    @IBAction func selectIcon(_ sender: Any) {
        imagesView.isHidden = false
    }
    
    @IBAction func selectedIconAmigos(_ sender: UIButton) {
        imagen = "amigos"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconHospital(_ sender: UIButton) {
        imagen = "hospital"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconEmergencia(_ sender: UIButton) {
        imagen = "emergencia"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconCafe(_ sender: UIButton) {
        imagen = "cafe"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconServicios(_ sender: UIButton) {
        imagen = "servicios"
        imagesView.isHidden = true
        
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconTrabajo(_ sender: UIButton) {
        imagen = "trabajo"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconAmigos2(_ sender: UIButton) {
        imagen = "amigos2"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconCorazonMedico(_ sender: UIButton) {
        imagen = "corazonMedico"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconServiciosSalud(_ sender: UIButton) {
        imagen = "serviciosSalud"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconServiciosHogar(_ sender: UIButton) {
        imagen = "serviciosHogar"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconHogar(_ sender: UIButton) {
        imagen = "hogar"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    @IBAction func selectedIconAlerta(_ sender: UIButton) {
        imagen = "alerta"
        imagesView.isHidden = true
        actualizarDato(img: (sender.imageView?.image)!)
    }
    
    
    
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               let vistaPopOver = segue.destination as! PopOverViewController
           vistaPopOver.popoverPresentationController!.delegate = self
        vistaPopOver.imagen = iconImageView.image
        
        if let imagen = iconImageView.image {
            vistaPopOver.imagen = imagen
        }
           
       }
}


