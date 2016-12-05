//
//  ViewController.swift
//  QuizzSwift
//
//  Created by m2sar on 17/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var facil = QuestionsReponses().easyQuizz
    var difficil = QuestionsReponses().hardQuizz
    var taille : Int = 0
    var indexFacil : Int = 0
    var indexDifficil : Int = 0
    var compteur : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taille = facil.count
        switchMode.isOn = false
        queryLabel.text = facil[indexFacil].0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var nextOutlet: UIButton!
    @IBOutlet weak var previousOutlet: UIButton!
    @IBOutlet weak var queryLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!

    @IBOutlet weak var nbResponse: UILabel!
    @IBOutlet weak var switchMode: UISwitch!
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if(switchMode.isOn){
            NSLog("Switch -> Index difficil : %d", indexDifficil)
            if(difficil[indexDifficil].2 == false){
                responseLabel.text = ""
            }else{
                responseLabel.text = difficil[indexDifficil].1
            }
            
            queryLabel.text = difficil[indexDifficil].0
        }else{
            NSLog("Switch -> Index facil : %d", indexFacil)
            if(facil[indexFacil].2 == false){
                responseLabel.text = ""
            }else{
                responseLabel.text = facil[indexFacil].1
            }
            
            queryLabel.text = facil[indexFacil].0
        }
    }
    
    @IBAction func navBar(_ sender: UIButton) {
        // Hardcore mode activated
        if(switchMode.isOn){
            // Next button
            if(sender == nextOutlet){
                indexDifficil += 1
                
                if(indexDifficil < taille){
                    if(difficil[indexDifficil].2 == false){
                        responseLabel.text = ""
                    }else{
                        responseLabel.text = difficil[indexDifficil].1
                    }
                    
                    queryLabel.text = difficil[indexDifficil].0
                }else{
                    indexDifficil = 0
                    
                    queryLabel.text = difficil[indexDifficil].0
                    
                    if(difficil[indexDifficil].2 == true){
                        responseLabel.text = difficil[indexDifficil].1
                    }else{
                        responseLabel.text = ""
                    }
                }
            // Previous button
            }else{
                indexDifficil -= 1
                
                if(indexDifficil >= 0){
                    if(difficil[indexDifficil].2 == false){
                        responseLabel.text = ""
                    }else{
                        responseLabel.text = difficil[indexDifficil].1
                    }

                    queryLabel.text = difficil[indexDifficil].0
                }else{
                    indexDifficil = taille-1
                    
                    queryLabel.text = difficil[indexDifficil].0
                    
                    if(difficil[indexDifficil].2 == true){
                        responseLabel.text = difficil[indexDifficil].1
                    }else{
                        responseLabel.text = ""
                    }
                }
            }
        // Hardcore mode disabled
        }else{
            // Next button
            if(sender === nextOutlet){
                indexFacil += 1
                
                if(indexFacil < taille){
                    if(facil[indexFacil].2 == false){
                        responseLabel.text = ""
                    }else{
                        responseLabel.text = facil[indexFacil].1
                    }
                    
                    queryLabel.text = facil[indexFacil].0
                }else{
                    indexFacil = 0
                    
                    queryLabel.text = facil[indexFacil].0
                    
                    if(facil[indexFacil].2 == true){
                        responseLabel.text = facil[indexFacil].1
                    }else{
                        responseLabel.text = ""
                    }
                }
            // Previous button
            }else{
                indexFacil -= 1
                if(indexFacil >= 0){
                    if(facil[indexFacil].2 == false){
                        responseLabel.text = ""
                    }else{
                        responseLabel.text = facil[indexFacil].1
                    }
                    
                    queryLabel.text = facil[indexFacil].0
                }else{
                    indexFacil = taille-1
                    
                    queryLabel.text = facil[indexFacil].0
                    
                    if(facil[indexFacil].2 == true){
                        responseLabel.text = facil[indexFacil].1
                    }else{
                        responseLabel.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func solutionAction(_ sender: UIButton) {
        if(switchMode.isOn){
            if(difficil[indexDifficil].2 == false){
                NSLog("Sol -> Index difficil : %d", indexDifficil)
                difficil[indexDifficil].2 = true
                responseLabel.text = difficil[indexDifficil].1
                compteur += 1
                nbResponse.text = String(format: "Réponses vues: %d", compteur)
            }
        }else{
            if(facil[indexFacil].2 == false){
                NSLog("Sol -> Index facil : %d", indexFacil)
                facil[indexFacil].2 = true
                responseLabel.text = facil[indexFacil].1
                compteur += 1
                nbResponse.text = String(format: "Réponses vues: %d", compteur)
            }
        }
        
    }
    
}

