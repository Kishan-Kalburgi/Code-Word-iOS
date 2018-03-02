//
//  ViewController.swift
//  SecretCode
//
//  Created by Kalburgi Srinivas,Kishan on 3/1/18.
//  Copyright © 2018 Kalburgi Srinivas,Kishan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var guessLBL: UILabel!
    @IBOutlet weak var statusLBL: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func resetAction(_ sender: Any) {
        
    }
    
}

