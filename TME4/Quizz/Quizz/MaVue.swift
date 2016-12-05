//
//  MaVue.swift
//  Quizz
//
//  Created by m2sar on 21/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation

import UIKit

class MaVue: UIView{
    private let terminal = UIDevice.current
    private let screen = UIScreen.main
    
    private var sommet = 0
    private var increment = 0
    
    // Label fixe Question / Réponse
    let labelQuestion = UILabel()
    let labelReponse = UILabel()
    let labelVues = UILabel()
    let labelMode = UILabel()
    
    // Affichage de la question et de la réponse
    let laQuestion = UILabel()
    let laReponse = UILabel()
    
    let switchMode = UISwitch()
    
    let solution = UIButton(type: .system)
    let suivant = UIButton(type: .system)
    let precedent = UIButton(type: .system)
    
    required init?(coder aDecoder:  NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        labelQuestion.text = "La question"
        labelQuestion.textAlignment = .center
        
        labelReponse.text = "La réponse"
        labelReponse.textAlignment = .center
        
        labelMode.text = "Mode Hardcore"
        labelMode.textAlignment = .center
        
        labelVues.text = "Réponses vues: 0"
        
        laQuestion.textColor = UIColor.blue
        laQuestion.textAlignment = .center
        
        laReponse.textColor = UIColor.green
        laReponse.textAlignment = .center
        
        solution.setTitle("La solution", for: UIControlState.normal)
        
        
        suivant.setImage(#imageLiteral(resourceName: "suivant"), for: UIControlState.normal)
        precedent.setImage(#imageLiteral(resourceName: "precedent"), for: UIControlState.normal)
        
        //suivant.layer.cornerRadius = 5
        //suivant.layer.borderWidth = 1
        //suivant.layer.borderColor = UIColor.black.cgColor
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(solution)
        self.addSubview(suivant)
        self.addSubview(precedent)
        self.addSubview(switchMode)
        self.addSubview(laQuestion)
        self.addSubview(laReponse)
        self.addSubview(labelQuestion)
        self.addSubview(labelReponse)
        self.addSubview(labelMode)
        self.addSubview(labelVues)
        
        solution.addTarget(self.superview, action:#selector(ViewController.solution), for: .touchDown)
        
        suivant.addTarget(self.superview, action: #selector(ViewController.navBar), for: .touchDown)
        
        precedent.addTarget(self.superview, action: #selector(ViewController.navBar), for: .touchDown)
        
        switchMode.addTarget(self.superview, action: #selector(ViewController.switchAction), for: .valueChanged)
        
    }
    
    override func draw(_ rect: CGRect) {
        
        solution.frame = CGRect(x: self.bounds.midX - self.bounds.width * 25/100/2,
                                y: self.bounds.height * 5/100,
                                width: self.bounds.width * 25/100,
                                height: self.bounds.height * 4/100)
        
        labelQuestion.frame = CGRect(x: self.bounds.midX-self.bounds.width/3/2,
                                     y: self.bounds.height * 10/100,
                                     width: self.bounds.width / 3,
                                     height: self.bounds.height * 4/100)
        
        labelReponse.frame = CGRect(x: self.bounds.midX - self.bounds.width/3/2,
                                    y: self.bounds.height * 47/100,
                                    width: self.bounds.width / 3,
                                    height: self.bounds.height * 4/100)
        
        suivant.frame = CGRect(x: self.bounds.width * 75/100,
                               y: self.bounds.height * 5/100,
                               width: self.bounds.width * 25/100,
                               height: self.bounds.height * 4/100)
        
        precedent.frame = CGRect(x: self.bounds.width * 5/100,
                                 y: self.bounds.height * 5/100,
                                 width: self.bounds.width * 25/100,
                                 height: self.bounds.height * 4/100)
        
        labelMode.frame = CGRect(x: self.bounds.width * 50/100,
                                 y: self.bounds.height * 85/100,
                                 width: self.bounds.width * 40/100,
                                 height: self.bounds.height * 4/100)
        
        switchMode.frame = CGRect(x: self.bounds.width * 75/100,
                                  y: self.bounds.height * 90/100,
                                  width: self.bounds.width * 30/100,
                                  height: self.bounds.height * 4/100)
        
        labelVues.frame = CGRect(x: self.bounds.width * 10/100,
                                 y: self.bounds.height * 90/100,
                                 width: self.bounds.width * 60/100,
                                 height: self.bounds.height * 4/100)
        
        laQuestion.frame = CGRect(x: self.bounds.width * 10/100,
                                  y: self.bounds.height * 15/100,
                                  width: self.bounds.width * 80/100,
                                  height: self.bounds.height * 30/100)
        laQuestion.backgroundColor = UIColor.lightGray
        
        laReponse.frame = CGRect(x: self.bounds.width * 10/100,
                                 y: self.bounds.height * 52/100,
                                 width: self.bounds.width * 80/100,
                                 height: self.bounds.height * 30/100)
        laReponse.backgroundColor = UIColor.lightGray
    }
    
}
