//
//  ViewController.swift
//  CalculatorJS
//
//  Created by apple on 2020/10/20.
//  Copyright © 2020 JersyShin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cc = CalculatorCore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var Result: UILabel!
    
    @IBAction func NumRelated(_ sender: UIButton) {
        let x = sender.titleLabel?.text
        Result.text = cc.NumExtention(x!)
    }
    

    @IBAction func CalRelated(_ sender: UIButton) {
        let x = sender.titleLabel?.text
        Result.text = cc.OperatorDivider(x!)
    }
    
}

