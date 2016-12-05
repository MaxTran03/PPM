//
//  GameView.swift
//  Asteroide
//
//  Created by m2sar on 07/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation

import UIKit

class GameView : UIView{
    
    let playButton = UIButton()
    let scoreButton = UIButton()
    let prefButton = UIButton()
    var blurEffectView = UIVisualEffectView()
    
    var labelScore = UILabel()
    var labelLevel = UILabel()
    let rightButton = UIButton()
    let leftButton = UIButton()
    let chasseur = UIImageView()
    var asteroideArray = [UIImageView.init(image: #imageLiteral(resourceName: "asteroide-100-1")),
                                  UIImageView.init(image:#imageLiteral(resourceName: "asteroide-100-2")),
                                  UIImageView.init(image:#imageLiteral(resourceName: "asteroide-100-3")),
                                  UIImageView.init(image:#imageLiteral(resourceName: "asteroide-100-4")),
                                  UIImageView.init(image:#imageLiteral(resourceName: "asteroide-120-1")),
                                  UIImageView.init(image:#imageLiteral(resourceName: "asteroide-120-2")),
                                  UIImageView.init(image:#imageLiteral(resourceName: "asteroide-120-3")),
                                  UIImageView.init(image:#imageLiteral(resourceName: "asteroide-120-4"))]
    
    var isAsteroideAlive = [false, false, false, false, false, false, false, false]
    var asteroideX = [0, 0, 0, 0, 0, 0, 0, 0]
    
    var scoreValue : NSInteger = 0
    
    let vPref = PrefView(frame: UIScreen.main.bounds)
    let vScore = ScoreView(frame: UIScreen.main.bounds)
    
    var navigTimer = Timer()
    var asteroideTimer : Timer?
    var labelTimer = Timer()
    
    var random : Int = 0
    var angle : CGFloat = 0.0
    var pi : CGFloat = 3.14
    
    var gameOverLabel = UILabel()
    var isOver : Bool = false
    
    let global = Global()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        
        // Avant PLAY
        playButton.setTitle("Play", for: .normal)
        scoreButton.setTitle("Scores", for: .normal)
        prefButton.setTitle("Préférences", for: .normal)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = self.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        self.backgroundColor = UIColor.clear
        
        self.addSubview(blurEffectView)//0
        self.addSubview(playButton)//1
        self.addSubview(scoreButton)//2
        self.addSubview(prefButton)//3
        
        
        // Après PLAY
        labelScore.text = "Score : 0"
        labelLevel.text = "Niveau : 1"
        rightButton.setTitle(">>>", for: .normal)
        leftButton.setTitle("<<<", for: .normal)
        gameOverLabel.text = "Game Over !!"
        
        chasseur.image = UIImage(named: "chasseur-TIE")

        gameOverLabel.isHidden = true
        labelScore.isHidden = true
        labelLevel.isHidden = true
        rightButton.isHidden = true
        leftButton.isHidden = true
        chasseur.isHidden = true
        //move chasseur
        rightButton.addTarget(self, action: #selector(navigateAction), for: .touchDown)
        rightButton.addTarget(self, action: #selector(stopNavig), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(navigateAction), for: .touchDown)
        leftButton.addTarget(self, action: #selector(stopNavig), for: .touchUpInside)
        
        self.addSubview(labelLevel) //4
        self.addSubview(labelScore) //5
        self.addSubview(rightButton) //6
        self.addSubview(leftButton) //7
        self.addSubview(chasseur) //8
        self.addSubview(gameOverLabel) //9
        self.addSubview(vScore) //10
        self.addSubview(vPref) //11
        
        self.subviews[10].isHidden = true
        self.subviews[11].isHidden = true
        
        for i in 0...7{
            self.addSubview(asteroideArray[i])
            asteroideArray[i].isHidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Avant PLAY
        scoreButton.frame = CGRect(x: rect.size.width * 5/100,
                                  y: rect.size.height * 5/100,
                                  width: rect.size.width * 10/100,
                                  height: rect.size.height * 4/100)
        scoreButton.setTitleColor(.white, for: .normal)
        

        prefButton.frame = CGRect(x: rect.size.width * 75/100,
                                  y: rect.size.height * 5/100,
                                  width: rect.size.width * 20/100,
                                  height: rect.size.height * 4/100)
        prefButton.setTitleColor(.white, for: .normal)
        
        playButton.frame = CGRect(x: rect.size.width * 50/100 - rect.size.width * 10/100,
                                  y: rect.size.height * 50/100 - rect.size.height * 4/100,
                                  width: rect.size.width * 20/100,
                                  height: rect.size.height * 8/100)
        playButton.setTitleColor(.white, for: .normal)
        //playButton.setTitleColor(self.tintColor, for: .normal)
        playButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        
        
        
        // Après PLAY
        rightButton.frame = CGRect(x: rect.size.width * 92/100,
                                  y: rect.size.height * 90/100,
                                  width: rect.size.width * 5/100,
                                  height: rect.size.height * 8/100)
        rightButton.setTitleColor(.white, for: .normal)
        
        leftButton.frame = CGRect(x: rect.size.width * 3/100,
                                   y: rect.size.height * 90/100,
                                   width: rect.size.width * 5/100,
                                   height: rect.size.height * 8/100)
        leftButton.setTitleColor(.white, for: .normal)
        
        labelScore.frame = CGRect(x: rect.size.width * 67/100,
                                  y: rect.size.height * 5/100,
                                  width: rect.size.width * 30/100,
                                  height: rect.size.height * 4/100)
        labelScore.backgroundColor = UIColor.clear
        labelScore.textColor = UIColor.white
        labelScore.textAlignment = .right
        
        labelLevel.frame = CGRect(x: rect.size.width * 3/100,
                                  y: rect.size.height * 5/100,
                                  width: rect.size.width * 15/100,
                                  height: rect.size.height * 4/100)
        labelLevel.backgroundColor = UIColor.clear
        labelLevel.textColor = UIColor.white
        labelLevel.textAlignment = .left
        
        chasseur.frame = CGRect(x: rect.size.width / 2 - rect.size.width * 2.5/100,
                                y: rect.size.height * 90/100,
                                width: rect.size.width * 5/100,
                                height: rect.size.height * 10/100)
        
        gameOverLabel.frame = CGRect(x: rect.size.width * 35/100,
                                  y: rect.size.height * 45/100,
                                  width: rect.size.width * 30/100,
                                  height: rect.size.height * 10/100)
        gameOverLabel.backgroundColor = UIColor.clear
        gameOverLabel.textColor = UIColor.white
        gameOverLabel.textAlignment = .center
        gameOverLabel.font = UIFont.boldSystemFont(ofSize: 35)
    }
    
    func play() {
        // Après avoir appuyé sur PLAY
        blurEffectView.isHidden = true
        playButton.isHidden = true
        prefButton.isHidden = true
        scoreButton.isHidden = true
        
        labelScore.isHidden = false
        labelLevel.isHidden = false
        rightButton.isHidden = false
        leftButton.isHidden = false
        chasseur.isHidden = false
        
        labelLevel.text = "Niveau : \(vPref.levelSelected + 1)"
        
        for i in 0...7{
            self.asteroideArray[i].isHidden = false
            self.asteroideArray[i].center = CGPoint(x: 0, y: -self.frame.size.height * 15/100)
        }
        
        self.asteroideTimer?.invalidate()
        
        self.asteroideTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(randAsteroide), userInfo: nil, repeats: true)
    }
    
    func scores(){
        /*self.addSubview(vPref) //10
        self.addSubview(vScore) //11
        
        vPref.isHidden = true
        vScore.isHidden = false*/
        
        self.subviews[10].isHidden = false
        self.subviews[11].isHidden = true
        
    }
    
    func preference(){
        /*self.addSubview(vPref)//10
        self.addSubview(vScore)//11
        
        vPref.isHidden = false
        vScore.isHidden = true*/
        
        self.subviews[10].isHidden = true
        self.subviews[11].isHidden = false
    }
    
    
    func navigateAction(_ sender: UIButton) {
        if (sender  == self.rightButton){
            navigTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(goRight), userInfo: nil, repeats: true)
        }else{
            navigTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(goLeft), userInfo: nil, repeats: true)
        }
    }
    
    func goRight(){
        if (chasseur.frame.origin.x < (self.frame.width * 90/100 - chasseur.frame.size.width)) {
            chasseur.frame.origin.x += 1
        }
    }
    
    func goLeft(){
        if (chasseur.frame.origin.x > (self.frame.width * 10/100)) {
            chasseur.frame.origin.x -= 1
        }
    }

    func stopNavig(){
        navigTimer.invalidate()
    }
    
    /*
    func randNumbAsteroide(){
        random = (Int(arc4random_uniform(50)) + 20) * vPref.levelSelected / 2
    
    }*/
    
    func randAsteroide(){
        angle += 0.0628
        if(angle > 6.28){
            angle = 0.0
        }
        
        if(isOver == false){
            let rand = Int(arc4random() % 8)
            if(isAsteroideAlive[rand] == false){
                asteroideArray[rand].center = CGPoint(x:Int(arc4random()) % Int(UIScreen.main.bounds.maxX), y: -Int(self.frame.size.height * 15/100))
                isAsteroideAlive[rand] = true
                asteroideX[rand] = -1 + Int(arc4random() % 2)
            }

            for i in 0...7{
                let posX = Int(asteroideArray[i].center.x) + asteroideX[i]
                let posY = Int(asteroideArray[i].center.y) + vPref.levelSelected + 1
                asteroideArray[i].center = CGPoint(x: posX, y: posY)
                asteroideArray[i].transform = CGAffineTransform(rotationAngle: angle)
            }
            
            for i in 0...7{
                if(asteroideArray[i].center.y > UIScreen.main.bounds.maxY){
                    asteroideArray[i].center = CGPoint(x: UIScreen.main.bounds.maxX/2, y: -self.frame.size.height * 15/100)
                    scoreValue += 1
                    labelScore.text = "Score : \(self.scoreValue)"
                    isAsteroideAlive[i] = false
                }
            }
            
            // Test de collision
            for i in 0...7 {
                if((asteroideArray[i].center.y) >= (chasseur.center.y - UIScreen.main.bounds.maxY/16) && ((asteroideArray[i].center.x) > (chasseur.center.x - UIScreen.main.bounds.maxY/16) && ((asteroideArray[i].center.x) < (chasseur.center.x + UIScreen.main.bounds.maxY/16)))){
                
                    isOver = true
                    
                    for i in 0...7{
                        asteroideArray[i].isHidden = true
                        isAsteroideAlive[i] = false
                    }
                
                    self.gameOverLabel.isHidden = false
                
                    labelTimer.invalidate()
                    labelTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(printGameOver), userInfo: nil, repeats: false)
                    
                }
            }
        }
    }

    func printGameOver(){
        gameOverLabel.isHidden = true
        leftButton.isHidden = true
        rightButton.isHidden = true
        chasseur.isHidden = true
        labelScore.isHidden = true
        labelLevel.isHidden = true
        
        //self.isHidden = true
        //vScore.isHidden = false
        self.subviews[10].isHidden = false
        
        asteroideTimer?.invalidate()
        asteroideTimer = nil
        
        global.currentScore = scoreValue
        scoreValue = 0
        vScore.yourScore.text = "\(global.currentScore)"
        global.indexScore = vScore.bestScoreAction(n: global.currentScore)
        
    }
}
