//
//  ViewController.swift
//  Quizz
//
//  Created by m2sar on 21/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var facile = QuestionsReponses().easyQuizz
    var difficile = QuestionsReponses().hardQuizz
    var taille : Int = 0
    var indexFacile : Int = 0
    var indexDifficile : Int = 0
    var compteur : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = MaVue(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        
        let v = self.view as! MaVue
        v.laQuestion.text = facile[indexFacile].0
        v.laReponse.text = ""
        v.switchMode.isOn = false
        taille = facile.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func solution (sender: UIButton!){
        let v = self.view as! MaVue
        
        if(v.switchMode.isOn){
            if(difficile[indexDifficile].2 == false){
                difficile[indexDifficile].2 = true
                affichage(difficulty: "difficile")
                compteur += 1
                v.labelVues.text = String(format: "Réponses vues: %d", compteur)
            }
        }else{
            if(facile[indexFacile].2 == false){
                facile[indexFacile].2 = true
                affichage(difficulty: "facile")
                compteur += 1
                v.labelVues.text = String(format: "Réponses vues: %d", compteur)
            }
        }
        
    }
    
    func affichage(difficulty : String){
        let v = self.view as! MaVue
        
        if(difficulty == "difficile"){
            if(difficile[indexDifficile].2 == false){
                v.laReponse.text = ""
            }else{
                v.laReponse.text = difficile[indexDifficile].1
            }
            v.laQuestion.text = difficile[indexDifficile].0
        }else if (difficulty == "facile"){
            if(facile[indexFacile].2 == false){
                v.laReponse.text = ""
            }else{
                v.laReponse.text = facile[indexFacile].1
            }
            v.laQuestion.text = facile[indexFacile].0
        }
    }
    
    func increment(n : Int, t: Int) -> Int{
        var val = n
        val += 1
        if(val >= t){
            val = 0
        }
        return val
    }
    
    func decrement(n : Int, t : Int) -> Int{
        var val = n
        val -= 1
        if(val < 0){
            val = t-1
        }
        return val
    }
    
    func navBar(sender: UIButton!){
        let v = self.view as! MaVue
        
        if(v.switchMode.isOn){
            if(sender == v.suivant){
                indexDifficile = increment(n: indexDifficile, t: taille)
                affichage(difficulty: "difficile")
            }else{
                indexDifficile = decrement(n: indexDifficile, t: taille)
                affichage(difficulty: "difficile")
            }
        }else{
            if(sender == v.suivant){
                indexFacile = increment(n: indexFacile, t: taille)
                affichage(difficulty: "facile")
            }else{
                indexFacile = decrement(n: indexFacile, t: taille)
                affichage(difficulty: "facile")
            }
        }
    }
    
    func switchAction(sender: UISwitch){
        let v = self.view as! MaVue
        
        if(v.switchMode.isOn){
            affichage(difficulty: "difficile")
        }else{
            affichage(difficulty: "facile")
        }
    }
}

