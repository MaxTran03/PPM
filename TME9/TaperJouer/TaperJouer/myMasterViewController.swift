//
//  myMasterViewController.swift
//  TaperJouer
//
//  Created by Max Corp on 12/4/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

/****** Protocole myMasterViewControllerDelegate ******/
protocol myMasterViewControllerDelegate: class {
    func replaySong(song: MPMediaItem)
}

class myMasterViewController : UITableViewController, UISplitViewControllerDelegate, myDetailViewControllerDelegate{
    
    var detailVC : myDetailViewController?
    var historicMusicTable = [MPMediaItem]()
    
    weak var delegate : myMasterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Historic"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let size = self.navigationController?.topViewController?.view.frame.size
        self.drawSize(size: size!)
        
        self.detailVC?.delegate = self
    }
    
    func drawSize(size: CGSize){
        self.tableView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    /****** Protocole UISplitViewControllerDelegate ******/
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        let access = detailVC?.navigationController?.topViewController?.navigationItem
        if(displayMode == .primaryHidden){
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
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicMusicTable.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myMusic")
        
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myMusic")
        }
        
        cell?.textLabel?.text = historicMusicTable[indexPath.row].title
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.replaySong(song: historicMusicTable[indexPath.row])
    }
    
    /****** Protocole myDetailViewControllerDelegate ******/
    func addSongToHistoric(song: MPMediaItem) {
        let songToAdd = song
        if(!historicMusicTable.contains(songToAdd)){
            self.historicMusicTable.append(songToAdd)
        }
        self.tableView.reloadData()
    }
}
