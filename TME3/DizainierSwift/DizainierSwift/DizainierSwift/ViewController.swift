//
//  ViewController.swift
//  DizainierSwift
//
//  Created by m2sar on 07/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepperOutlet.minimumValue = 0;
        stepperOutlet.maximumValue = 99;
        
        switchOulet.isOn = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var switchOulet: UISwitch!
    @IBOutlet weak var dizaineOutlet: UISegmentedControl!
    @IBOutlet weak var uniteOutlet: UISegmentedControl!
    @IBOutlet weak var labelAffiche: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        uniteOutlet.selectedSegmentIndex = Int(stepperOutlet.value) % 10;
        dizaineOutlet.selectedSegmentIndex = Int(stepperOutlet.value) / 10;
        sliderOutlet.value = Float(stepperOutlet.value);
        
        updateLabel();
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        dizaineOutlet.selectedSegmentIndex = Int(sliderOutlet.value) / 10;
        uniteOutlet.selectedSegmentIndex = Int(sliderOutlet.value) % 10;
        stepperOutlet.value = Double(sliderOutlet.value);
        
        updateLabel();
    }
    
    @IBAction func dizaineSegmented(_ sender: UISegmentedControl) {
        sliderOutlet.value = Float(uniteOutlet.selectedSegmentIndex + dizaineOutlet.selectedSegmentIndex*10);
        stepperOutlet.value = Double(sliderOutlet.value);
    
        updateLabel();
    }
    
    @IBAction func uniteSegmented(_ sender: UISegmentedControl) {
        sliderOutlet.value = Float(uniteOutlet.selectedSegmentIndex + dizaineOutlet.selectedSegmentIndex*10);
        stepperOutlet.value = Double(sliderOutlet.value);
        
        updateLabel();
    }
    
    func updateLabel(){
        if(switchOulet.isOn){
            labelAffiche.textColor = UIColor.red;
            labelAffiche.text = String(format:"%X", Int(sliderOutlet.value));
        }else{
            labelAffiche.textColor = UIColor.black;
            labelAffiche.text = String(format:"%d", Int(sliderOutlet.value));
        }
    }
    
    @IBAction func RaZ(_ sender: UIButton) {
        stepperOutlet.value = 0;
        uniteOutlet.selectedSegmentIndex = 0;
        dizaineOutlet.selectedSegmentIndex = 0;
        sliderOutlet.value = 0;
        
        updateLabel();
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        updateLabel();
    }
}

