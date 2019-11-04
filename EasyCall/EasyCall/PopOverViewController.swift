//
//  PopOverViewController.swift
//  EasyCall
//
//  Created by Martha Arnaud on 11/3/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {

    var imagen: UIImageView!
    
    @IBAction func btListo(_ sender: UIButton) {
        let vista1 = presentingViewController as! agregarCategoriaViewController
        vista1.dato = tfMensaje.text!
               vista1.actualizarDato()
               dismiss(animated: true, completion: nil)
        
        
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()

     preferredContentSize = CGSize(width: 250, height: 250)
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
