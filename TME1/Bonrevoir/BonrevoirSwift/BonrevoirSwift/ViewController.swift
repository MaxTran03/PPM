//
//  ViewController.swift
//  BonrevoirSwift
//
//  Created by m2sar on 26/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
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

    @IBOutlet weak var myButton: UIButton!

    @IBOutlet weak var LabAffiche: UILabel!
    
    var test = true;
    @IBAction func buttonAction(_ sender: UIButton) {
        if(!test){
            LabAffiche.text="Au revoir le monde"
            myButton.setTitle("Dis Bonjour", for: UIControlState.normal)
            test = true
        }else{
            LabAffiche.text="Bonjour le monde"
            myButton.setTitle("Dis Au Revoir", for: UIControlState.normal)
            test = false
        }
    }
    
}

