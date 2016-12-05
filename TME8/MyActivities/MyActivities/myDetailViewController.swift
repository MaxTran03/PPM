//
//  myDetailViewController.swift
//  MyActivities
//
//  Created by Max Corp on 11/28/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

import Foundation
import UIKit

/****** Protocole myDetailViewControllerDelegate ******/
protocol myDetailViewControllerDelegate: class {
    func updateTaskTitle(title: String)
    func updateTaskPriority(prio: Int)
}

class myDetailViewController : UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate{
    let titleLabel = UILabel()
    let priorityLabel = UILabel()
    var titleTextField = UITextField()
    var prioritySegmentedControl = UISegmentedControl()
    var cameraButtonItem = UIBarButtonItem()
    var currentTask = Task()
    
    var pictureScrollView = UIScrollView()
    var pictureView = UIImageView()
    var picturePicker = UIImagePickerController()
    
    weak var delegate : myDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Title: "
        priorityLabel.text = "Priority: "
        
        titleTextField.borderStyle = .roundedRect
        titleTextField.clearButtonMode = .always
        titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange), for: .editingChanged)
        //titleTextField.delegate = self
        
        prioritySegmentedControl = UISegmentedControl(items: ["0", "1", "2", "3", "4"])
        prioritySegmentedControl.tintColor = UIColor.white
        prioritySegmentedControl.addTarget(self, action: #selector(prioritySegmentedControlDidChange), for: .valueChanged)
        
        // Ajout du bouton camera à la barre de navigation
        cameraButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraAction))
        self.navigationController?.topViewController?.navigationItem.rightBarButtonItem = cameraButtonItem
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fond-alu")!)
        
        self.drawSize(size: self.view.frame.size)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(priorityLabel)
        self.view.addSubview(titleTextField)
        self.view.addSubview(prioritySegmentedControl)
        self.view.addSubview(pictureView)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.drawSize(size: size)
    }
    
    
    func drawSize(size : CGSize){
        
        self.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        // Landscape
        if((UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) && (size.height < size.width) && (UIScreen.main.scale != 3.0)){
            titleLabel.frame = CGRect(x: size.width * 5/100, y: size.height * 10/100, width: size.width * 10/100, height: size.height * 4/100)
            
            titleTextField.frame = CGRect(x: size.width * 20/100, y: size.height * 8/100, width: size.width * 50/100, height: size.height * 8/100)
            
            priorityLabel.frame = CGRect(x: size.width * 5/100, y: size.height * 20/100, width: size.width * 10/100, height: size.height * 4/100)
            
            prioritySegmentedControl.frame = CGRect(x: size.width * 5/100, y: size.height * 30/100, width: size.width * 90/100, height: size.height * 10/100)
            
            pictureView.frame = CGRect(x: size.width * 25/100, y: size.height * 45/100, width: size.width * 50/100, height: size.height * 50/100)
            //pictureView.backgroundColor = UIColor.black
            
        }else{
            // Portrait
            titleLabel.frame = CGRect(x: size.width * 5/100, y: size.height * 10/100, width: size.width * 15/100, height: size.height * 4/100)
            
            titleTextField.frame = CGRect(x: size.width * 25/100, y: size.height * 10/100, width: size.width * 70/100, height: size.height * 4/100)
            
            priorityLabel.frame = CGRect(x: size.width * 5/100, y: size.height * 20/100, width: size.width * 20/100, height: size.height * 4/100)
            
            prioritySegmentedControl.frame = CGRect(x: size.width * 5/100, y: size.height * 26/100, width: size.width * 90/100, height: size.height * 8/100)
            
            pictureView.frame = CGRect(x: size.width * 5/100, y: size.height * 45/100, width: size.width * 90/100, height: size.height * 50/100)
            //pictureView.backgroundColor = UIColor.black
        }
        
    }
    
    /****** Protocole UITextFieldDelegate ******/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    /*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //var newText = textField.text?.replacingCharacters(in: <#T##Range<String.Index>#>, with: string)
        self.delegate?.updateTaskTitle(title: textField.text!)
        
        return true
    }*/
    
    
    /****** Protocole UIImagePickerControllerDelegate ******/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var img = info[UIImagePickerControllerEditedImage] as! UIImage
        self.currentTask.image = img
        pictureView.image = self.currentTask.image
        
        picturePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picturePicker.dismiss(animated: true, completion: nil)
    }
    
    /****** Functions ******/
    func cameraAction(){
        picturePicker.delegate = self
        picturePicker.sourceType = UIImagePickerControllerSourceType.camera
        
        var mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.camera)
        picturePicker.mediaTypes = mediaTypes!
        picturePicker.allowsEditing = true
        
        self.present(picturePicker, animated: true, completion: nil)
    }
    
    func prioritySegmentedControlDidChange(){
        NSLog("#### SELECT PRIO: \(prioritySegmentedControl.selectedSegmentIndex)")
        self.delegate?.updateTaskPriority(prio: prioritySegmentedControl.selectedSegmentIndex)
    }
    
    
    func titleTextFieldDidChange(textField: UITextField){
        self.delegate?.updateTaskTitle(title: textField.text!)
    }
    
    func updateTaskDetail(t: Task){
        self.currentTask = t
        self.titleTextField.text = self.currentTask.taskTitle
        self.prioritySegmentedControl.selectedSegmentIndex = self.currentTask.priority
    }
    
}

/****** Protocole taskSelectionDelegate ******/
extension myDetailViewController: TaskSelectionDelegate{
    func taskSelected(newTask: Task) {
        self.currentTask = newTask
        self.updateTaskDetail(t: self.currentTask)
    }
}
