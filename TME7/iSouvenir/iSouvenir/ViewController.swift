//
//  ViewController.swift
//  iSouvenir
//
//  Created by m2sar on 24/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var mV : myView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mV = myView(frame : self.view.frame)
        self.view = mV
        // Do any additional setup after loading the view, typically from a nib.
        
        if CLLocationManager.locationServicesEnabled(){
            self.view = mV
        }else{
            self.view = UIView()
            let alert = UIAlertController(title: "Erreur", message: "Localisation désactivée", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        mV.photoPicker.sourceType = .photoLibrary
        present(mV.photoPicker, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

