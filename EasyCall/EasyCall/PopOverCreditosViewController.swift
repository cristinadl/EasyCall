//
//  PopOverCreditosViewController.swift
//  EasyCall
//
//  Created by Martha Arnaud on 11/21/19.
//  Copyright © 2019 Mm. All rights reserved.
//

import UIKit

class PopOverCreditosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
preferredContentSize = CGSize(width: 350, height: 350)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btOk(_ sender: UIButton) {
//        let vista1 = presentingViewController as! misCategoriasViewController
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista1 = presentingViewController as! misCategoriasViewController
        dismiss(animated: true, completion: nil)
    }
    

}
