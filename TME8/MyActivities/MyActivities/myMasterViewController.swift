//
//  myMasterViewController.swift
//  MyActivities
//
//  Created by Max Corp on 11/28/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

import Foundation
import UIKit

/******* Protocole Task ******/
protocol TaskSelectionDelegate: class{
    func taskSelected(newTask: Task)
}

class myMasterViewController : UITableViewController, UISplitViewControllerDelegate, myDetailViewControllerDelegate{
    
    var detailVC : myDetailViewController?
    var nestedTask = [Task]()
    var taskTable = [[Task]]()
    var sectionTable = [String]()
    var splitVC : UISplitViewController?
    var selectedTask = Task()
    
    weak var delegate: TaskSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Task list"
        self.selectedTask = Task(title: "", prio: 0)
        
        sectionTable = ["Holidays", "Personal", "Urgent", "Today"]
        for i in 0...sectionTable.count{
            switch i {
            case 0:
                nestedTask = [Task(title: "Enjoy the holidays", prio: 4)]
            case 1:
                nestedTask = [Task(title: "Do the grossery", prio: 2)]
            case 2:
                nestedTask = [Task(title: "Get me a present", prio: 3)]
            case 3:
                nestedTask = [Task(title: "Drink my coffee", prio: 0)]
            default:
                ()
            }
            taskTable += [nestedTask]
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let size = self.navigationController?.topViewController?.view.frame.size
        self.drawSize(size: size!)
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "fond-alu"))
        
        self.detailVC?.delegate = self
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskAction))
        
    }
    
    func drawSize(size: CGSize){
        self.tableView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    /****** Functions ******/
    func addTaskAction(){
        self.taskTable[1].insert(Task(title: "New task", prio: 0), at: 1)
        self.tableView.reloadData()
    }
    
    
    /****** Protocole UISplitViewControllerDelegate ******/
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        let access = detailVC?.navigationController?.topViewController?.navigationItem
        if(displayMode == .primaryHidden){
            NSLog("###### PRIMARY HIDDEN")
            access?.setLeftBarButton(svc.displayModeButtonItem, animated: true)
        }else{
            access?.setLeftBarButton(nil, animated: true)
        }
    }
    
    func targetDisplayModeForAction(in svc: UISplitViewController) -> UISplitViewControllerDisplayMode {
        let access = detailVC?.navigationController?.topViewController?.navigationItem
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone){
            return UISplitViewControllerDisplayMode.allVisible
        }else{
            access?.setLeftBarButton(svc.displayModeButtonItem, animated: true)
            return UISplitViewControllerDisplayMode.automatic
        }
    }
    
    /****** Protocole UITableViewDelegate ******/
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTable.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTable[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTable[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myIdentifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: myIdentifier)
        
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: myIdentifier)
        }
        
        let cont = taskTable[indexPath.section][indexPath.row]
        cell?.textLabel?.text = cont.taskTitle
        cell?.detailTextLabel?.text = "Current priority: \(cont.priority)"
        cell?.imageView?.image = UIImage(named: "prio-\(cont.priority)")
        cell?.backgroundView = UIImageView(image: UIImage(named: "bg-tableview-cell"))
        cell?.selectedBackgroundView = UIImageView(image: UIImage(named: "bg-tableview-cell-sel"))
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movingTask = taskTable[sourceIndexPath.section][sourceIndexPath.row]
        
        taskTable[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        taskTable[destinationIndexPath.section].insert(movingTask, at: destinationIndexPath.row)
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTask = taskTable[indexPath.section][indexPath.row]
        self.delegate?.taskSelected(newTask: selectedTask)
        
        if let dvc = self.delegate as? myDetailViewController{
            splitViewController?.showDetailViewController(dvc.navigationController!, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            self.taskTable[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }else if(editingStyle == .insert){
            
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
            header.backgroundView = UIImageView(image: UIImage(named: "bg-header"))
        }

    }
    
    
    /****** Protocole myDetailViewControllerDelegate ******/
    func updateTaskTitle(title: String) {
        selectedTask.taskTitle = title
        
        self.tableView.reloadData()
    }
    
    func updateTaskPriority(prio: Int) {
        selectedTask.priority = prio
        
        self.tableView.reloadData()
    }
}
