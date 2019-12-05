//
//  editarContactoViewController.swift
//  EasyCall
//
//  Created by Mm on 11/20/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

protocol protocoloEditarContacto {
    func eliminarContacto(contOriginal : Contacto) -> Void
    func actualizarDato(contOriginal : Contacto, cont: Contacto) -> Void
}

class editarContactoViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
     var delegado : protocoloEditarContacto!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorias.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return categorias[row].nombre
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var view = UIView()
        var img = UIImageView()
        view.frame = CGRect(x: -30, y: 0, width: 20, height: 20)
        img.frame = CGRect(x: -30, y: -30, width: 80, height: 80)
        img.image = UIImage(named: categorias[row].icon)
        var label = UILabel()
        label.frame = CGRect(x: -40, y: -40, width: 200, height: 20)
        label.text = categorias[row].nombre
        
        
        view.addSubview(img)
        view.addSubview(label)
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    
    @IBOutlet weak var picker: UIPickerView!
    
    var contacts = [Contacto]()
    var categorias = [Categoria]()
//    var pickerData: [[String]] = [[String]]()
    var pickerData = [Categoria(nombre: "amigos", icon: "amigos")]
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenerContactos()
        obtenerCategorias()
        
        self.picker.delegate = self
        self.picker.dataSource = self
        print(numCategory)
        var row = 0
        var count = 0
        
        for cat in categorias {
            if(cat.nombre == categoria){
                row = count
                print("row = \(row)")
            }else{
                count = count + 1
            }
        }
        self.picker.selectRow(row, inComponent: 0, animated: true)
        self.hideKeyboard()
        
        tfNombre.text = nombre
        tfApellido.text = apellido
        tfNumero.text = numero
        title = "Editar Contacto"
        
        // Do any additional setup after loading the view.
    }
    
    var nombre = ""
    var apellido = ""
    var numero = ""
    var categoria = ""
    var numCategory = 0
    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNumero: UITextField!
    
    @IBAction func eliminarContactoPressed(_ sender: Any) {
        
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "¿QUIERES ELIMINAR A ESTE CONTACTO?", message: "¿Estas seguro que quieres eliminar este contacto? Una vez eliminado, no se podra recuperar a este contacto.", preferredStyle: .alert)
        
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
        var contacto = Contacto(nombre: "", apellido: "", number: "", icon: "", emergencia: false, categoria: "")
        for cont in contacts {
            if(nombre == cont.nombre && apellido == cont.apellido && numero == cont.number){
                contacto = cont
            }
        }
        delegado.eliminarContacto(contOriginal: contacto)
//        navigationController?.popViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func guardarContactos() {
        var contacto = Contacto(nombre: "", apellido: "", number: "", icon: "", emergencia: false, categoria: "")
        for cont in contacts {
            if(nombre == cont.nombre && apellido == cont.apellido && numero == cont.number){
                contacto = cont
                contacto.nombre = tfNombre.text!
                contacto.apellido = tfApellido.text!
                contacto.number = tfNumero.text!
                contacto.categoria = categorias[picker.selectedRow(inComponent: 0)].nombre
                
                for cat in categorias {
                    if(cat.nombre == contacto.categoria){
                        contacto.icon = cat.icon
                    }
                }
                
                delegado.actualizarDato(contOriginal: cont, cont: contacto)
            }
        }
        
       navigationController?.popViewController(animated: true)
//    navigationController?.popToRootViewController(animated: true)

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
        
        
    }
    
    @IBAction func obtenerContactos() {
        // borro la lista para verificar que sí se obtengan
        contacts.removeAll()
        
        do {
            let data = try Data.init(contentsOf: dataFileUrl(namePlist: "Contactos"))
            contacts = try PropertyListDecoder().decode([Contacto].self, from: data)
        }
        catch {
            print("Error reading or decoding file")
        }
        
        
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

