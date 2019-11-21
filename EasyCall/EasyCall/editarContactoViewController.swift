//
//  editarContactoViewController.swift
//  EasyCall
//
//  Created by Mm on 11/20/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class editarContactoViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
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
        //pickerData = String[Categoria(nombre: "amigos", icon: "amigos")]
        self.hideKeyboard()
        
        tfNombre.text = nombre
        tfApellido.text = apellido
        tfNumero.text = numero
        
        // Do any additional setup after loading the view.
    }
    
    var nombre = ""
    var apellido = ""
    var numero = ""
    var categoria = ""
    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNumero: UITextField!
    
    
    @IBAction func guardarContactos() {
        var contact = Contacto(nombre: "", number: "", icon: "", emergencia: false, categoria:"")
        var contactDet = ContactDetails(givenName: "")
        
        if let nombre = tfNombre.text , let apellido = tfApellido.text{
            contact.nombre = nombre + " " + apellido
            contact.number = tfNumero.text!
        }
        
        
        contactDet.givenName = tfNombre.text!
        contactDet.familyName = tfApellido.text!
        contactDet.numbers = ["mobile":contact.number]
        
        self.contacts.append(contact)
        self.guardarContactoNuevo()
        RZNContacts.addContact(contactDet)
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
        
//        for cat in categorias {
//            print (cat.nombre, cat.icon)
//        }
        
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
        
        
        picker.selectRow(row, inComponent: 0, animated: true)
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
        
        //print(self.contacts[0].nombre + " " + self.contacts[0].categoria + " " + self.contacts[0].number)
        
    }
    
    @IBAction func guardarContactoNuevo() {
        
        //        print(contacts.count)
        do {
            let data = try PropertyListEncoder().encode(contacts)
            try data.write(to: dataFileUrl(namePlist: "Contactos"))
        }
        catch {
            print("Save Failed")
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

