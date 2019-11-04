//
//  PopOverViewController.swift
//  EasyCall
//
//  Created by Martha Arnaud on 11/3/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    var imagen: UIImage!
    
    @IBOutlet weak var btAmigos: UIButton!
    @IBOutlet weak var btHospital: UIButton!
    @IBOutlet weak var btEmergencia: UIButton!
    @IBOutlet weak var btCafe: UIButton!
    @IBOutlet weak var btServicios: UIButton!
    @IBOutlet weak var btTrabajo: UIButton!
    
    
    @IBAction func actionAmigos(_ sender: UIButton) {
        let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.imagen = btAmigos.imageView?.image
        vista1.actualizarDato()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionHospital(_ sender: UIButton) {
        let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.imagen = btHospital.imageView?.image
        vista1.actualizarDato()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionEmergencia(_ sender: UIButton) {
        let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.imagen = btEmergencia.imageView?.image
        vista1.actualizarDato()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionCafe(_ sender: UIButton) {
        let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.imagen = btCafe.imageView?.image
        vista1.actualizarDato()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionServicios(_ sender: UIButton) {
        let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.imagen = btServicios.imageView?.image
        vista1.actualizarDato()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func actionTrabajo(_ sender: UIButton) {
        let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.imagen = btTrabajo.imageView?.image
        vista1.actualizarDato()
        dismiss(animated: true, completion: nil)
    }
    
    
        override func viewDidLoad() {
        super.viewDidLoad()

     preferredContentSize = CGSize(width: 250, height: 250)
    }
    
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.imagen = btAmigos.imageView?.image
        vista1.actualizarDato()
        dismiss(animated: true, completion: nil)
    }
 */

}
