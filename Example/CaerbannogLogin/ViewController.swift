//
//  ViewController.swift
//  CaerbannogLogin
//
//  Created by leodegeus7 on 03/13/2018.
//  Copyright (c) 2018 leodegeus7. All rights reserved.
//

import UIKit
import CaerbannogLogin

class ViewController: UIViewController {

    @IBOutlet weak var imageBack: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageBack.image = #imageLiteral(resourceName: "fundoMain.png")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        CaerbanoggLogin.shared.logout(nextViewController: self)
    }
    
    
}
