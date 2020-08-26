//
//  ViewController.swift
//  sendReceiveParcel
//
//  Created by Федот Евсеев on 26.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .red
        
    }
    
    @IBAction func logoutAcc(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
    }
    
}

