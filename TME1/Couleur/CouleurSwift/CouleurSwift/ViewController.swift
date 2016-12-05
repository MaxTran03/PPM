//
//  ViewController.swift
//  CouleurSwift
//
//  Created by m2sar on 26/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colorTable:[UIColor] = [.white, .black, .yellow, .red, .green, .blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepperOutlet.minimumValue = 0.0
        stepperOutlet.maximumValue = 5.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        colorView.backgroundColor = colorTable[Int(stepperOutlet.value)]
        
    }
    
    
    
    
    
}

