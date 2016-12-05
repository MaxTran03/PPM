//
//  PrefView.swift
//  Asteroide
//
//  Created by m2sar on 07/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit

class PrefView : UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    let levelChoice = UIPickerView()
    let doneButton = UIButton()
    let labelChoice = UILabel()
    var choicesArray : [String] = ["Niveau 1", "Niveau 2", "Niveau 3", "Niveau 4", "Niveau 5"]
    var levelSelected : Int = 0
    var blurEffectView = UIVisualEffectView()
    
    let global = Global()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = self.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation

        
        labelChoice.text = "Sélectionnez le niveau de difficulté :"
        doneButton.setTitle("Done", for: .normal)
        
        /*
        for i in 0...4{
            NSLog("->>> \(i)")
            choicesArray[i].0 = "Niveau \(i+1)"
            choicesArray[i].1 = i+1
            NSLog("--> \(choicesArray[i].0)")
        }*/
        levelChoice.delegate = self
        levelChoice.dataSource = self
        levelChoice.showsSelectionIndicator = true
        levelChoice.backgroundColor = UIColor.clear
        
        levelSelected = levelChoice.selectedRow(inComponent: 0)
        global.level = levelSelected + 1
        levelChoice.selectedRow(inComponent: 0)
        
        self.doneButton.addTarget(self, action: #selector(doneAction), for: .touchDown)
        
        self.addSubview(blurEffectView)//0
        self.addSubview(levelChoice)//1
        self.addSubview(doneButton)//2
        self.addSubview(labelChoice)//3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        labelChoice.frame = CGRect(x: rect.size.width * 50/100 - rect.size.width * 20/100,
                                   y: rect.size.height * 10/100,
                                   width: rect.size.width * 40/100,
                                   height: rect.size.height * 4/100)
        
        levelChoice.frame = CGRect(x: rect.size.width * 50/100 - rect.size.width * 10/100,
                                   y: rect.size.height * 20/100,
                                   width: rect.size.width * 20/100,
                                   height: rect.size.height * 55/100)
        
        doneButton.frame = CGRect(x: rect.size.width * 85/100,
                                  y: rect.size.height * 5/100,
                                  width: rect.size.width * 10/100,
                                  height: rect.size.height * 4/100)
        doneButton.setTitleColor(self.tintColor, for: .normal)
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            levelSelected = levelChoice.selectedRow(inComponent: component)
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choicesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choicesArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func doneAction(){
        self.superview?.subviews[0].isHidden = false
        self.superview?.subviews[1].isHidden = false
        self.superview?.subviews[2].isHidden = false
        self.superview?.subviews[3].isHidden = false
        
        global.level = levelSelected + 1
        
        self.isHidden = true //vPref
        self.superview?.isHidden = false
        
    }
}
