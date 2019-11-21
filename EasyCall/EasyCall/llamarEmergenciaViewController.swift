//
//  llamarEmergenciaViewController.swift
//  EasyCall
//
//  Created by Mm on 11/20/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit
import CoreData
import Contacts

class llamarEmergenciaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    var emergencia = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("regresando a la pantalla")
                print("no. emergencia = \(contactosEmergencia.count)")
                tableView.reloadData()
    }
    
    
    
    func dataFileUrl(namePlist: String) -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent(namePlist + ".plist")
        return pathArchivo
    }
    
    @IBAction func editarPressed(_ sender: Any) {
        performSegue(withIdentifier: "ContactoEmergencia", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactosEmergencia.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! contactTableViewCell
        
        let name = contactosEmergencia[indexPath.row].getNombreCompleto()
        
        cell.nombreLabel.text = name
        
        cell.numeroLabel.text = contactosEmergencia[indexPath.row].number
        
        
        if(contactosEmergencia[indexPath.row].icon == ""){
            cell.iconImage.backgroundColor = UIColor.init(red:0/255, green: 191/255, blue: 214/255, alpha: 1)
            
        }else{
            cell.iconImage.image = UIImage(named: contactosEmergencia[indexPath.row].icon)
        }
        
        cell.iconImage.layer.cornerRadius = cell.iconImage.frame.width / 2
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

