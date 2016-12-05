//
//  ViewController.swift
//  MiniNav
//
//  Created by m2sar on 28/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let v = MaVue(frame: UIScreen.main.bounds)
    var newHome = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view = v
        v.backgroundColor = UIColor.white
        
        v.changeURL.addTextField(configurationHandler: {f -> Void in
            f.textColor = UIColor.blue
            f.text = "https://"
            self.v.answerURL = f})
        v.changeURL.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        v.changeURL.addAction(UIAlertAction(title: "Ok", style: .default, handler: readURL))
        
        v.changeHome.addTextField(configurationHandler: {f -> Void in
            f.textColor = UIColor.blue
            f.text = "https://"
            self.v.homeURL = f})
        v.changeHome.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        v.changeHome.addAction(UIAlertAction(title: "Ok", style: .default, handler: readHomeURL))
        
        v.homePreference.addAction(UIAlertAction(title: "Oui", style: .default, handler: savePreference))
        v.homePreference.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        
        v.nextButton.isEnabled = false
        v.previousButton.isEnabled = false
        
        newHome = "https://nasa.gov"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func validatePreference(){
        self.present(v.homePreference, animated: true, completion: {})
    }
    
    func savePreference(sender: UIAlertAction){
        //newHome = (v.webView.request?.url?.absoluteString)!
        self.present(v.changeHome, animated: true, completion: {})
    }
    
    func readURL(sender: UIAlertAction){
        let v = self.view as! MaVue
        v.loadURL(url: (self.v.answerURL.text!))
    }
    
    func readHomeURL(sender: UIAlertAction){
        newHome = v.homeURL.text!
    }
    
    func navigationBar(sender: UIBarButtonItem){
        if(sender == v.nextButton){
            v.forwardInWebView()
        }else{
            v.backwardInWebView()
        }
    }
    
    func newURL(){
        self.present(v.changeURL, animated: true, completion: {})
    }
    
    func refreshURL(){
        if(v.activityIndicator.isAnimating){
            v.activityIndicator.stopAnimating()
        }else{
            v.activityIndicator.startAnimating()
        }
        
        v.loadURL(url: newHome)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let v = self.view as! MaVue
        v.drawInFormat(format:size)
    }
    
}

