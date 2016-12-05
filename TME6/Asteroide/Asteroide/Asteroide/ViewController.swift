//
//  ViewController.swift
//  Asteroide
//
//  Created by m2sar on 07/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let vGame = GameView(frame: UIScreen.main.bounds)
    let vScore = ScoreView(frame: UIScreen.main.bounds)
    let vPref = PrefView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "fond-asteroides")
        
        self.view.addSubview(backgroundImage)//0
        self.view.addSubview(vGame)//1
        self.view.addSubview(vScore)//2
        self.view.addSubview(vPref)//3
        
        vScore.isHidden = true
        vPref.isHidden = true
        
        vPref.levelSelected = 1
        
        self.vGame.playButton.addTarget(self.vGame, action: #selector(vGame.play), for: .touchDown)
        self.vGame.scoreButton.addTarget(self.vGame, action: #selector(vGame.scores), for: .touchDown)
        self.vGame.prefButton.addTarget(self.vGame, action: #selector(vGame.preference), for: .touchDown)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

