//
//  myDetailViewController.swift
//  TaperJouer
//
//  Created by Max Corp on 12/4/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

protocol myDetailViewControllerDelegate: class {
    func addSongToHistoric(song: MPMediaItem)
}

class myDetailViewController : ViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIAdaptivePresentationControllerDelegate, UIPopoverPresentationControllerDelegate{
    
    var statusLabel = UILabel()
    var songLabel = UILabel()
    var songProgress = UIProgressView()
    var indexOfSongLabel = UILabel()
    
    var mediaPlayer = MPMusicPlayerController()
    
    var nextSongOnSwipeLeft = UISwipeGestureRecognizer()
    var prevSongOnSwipeRight = UISwipeGestureRecognizer()
    var stopSongOnDoubleTap = UITapGestureRecognizer()
    var playSongOnSingleTap = UITapGestureRecognizer()
    
    var songsArray = [MPMediaItem]()
    var mediaQuery = MPMediaQuery()
    
    let popover = UIViewController()
    let infoButton = UIButton(type: UIButtonType.infoLight)
    
    var masterVC : myMasterViewController?
    
    var isBeginning = true
    var isNext = true
    
    weak var delegate : myDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        masterVC = myMasterViewController()
        
        self.navigationItem.title = "Music"
        
        infoButton.addTarget(self, action: #selector(infoWindow), for: .touchDown)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = infoBarButtonItem
        
        
        
        statusLabel.text = "Stopped"
        statusLabel.textAlignment = .center
        
        songLabel.text = ""
        songLabel.textAlignment = .center
        
        songProgress.progress = 0
        
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateSongProgress), userInfo: nil, repeats: true)
        
        indexOfSongLabel.text = "0/0"
        indexOfSongLabel.textAlignment = .center
        
        mediaPlayer = MPMusicPlayerController.applicationMusicPlayer()
        
        nextSongOnSwipeLeft.direction = UISwipeGestureRecognizerDirection.left
        nextSongOnSwipeLeft.addTarget(self, action: #selector(nextSong))
        self.view.addGestureRecognizer(nextSongOnSwipeLeft)
        
        prevSongOnSwipeRight.direction = UISwipeGestureRecognizerDirection.right
        prevSongOnSwipeRight.addTarget(self, action: #selector(prevSong))
        self.view.addGestureRecognizer(prevSongOnSwipeRight)
        
        stopSongOnDoubleTap.numberOfTapsRequired = 2
        stopSongOnDoubleTap.addTarget(self, action: #selector(stopSong))
        self.view.addGestureRecognizer(stopSongOnDoubleTap)
        
        playSongOnSingleTap.numberOfTapsRequired = 1
        playSongOnSingleTap.addTarget(self, action: #selector(playSong))
        self.view.addGestureRecognizer(playSongOnSingleTap)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(songDidChange), name: .MPMusicPlayerControllerNowPlayingItemDidChange, object: self.mediaPlayer)
        
        notificationCenter.addObserver(self, selector: #selector(playbackStateDidChange), name: .MPMusicPlayerControllerPlaybackStateDidChange, object: self.mediaPlayer)
        
        mediaPlayer.beginGeneratingPlaybackNotifications()
        
        mediaPlayer.setQueue(with: mediaQuery)
        
        self.view.backgroundColor = UIColor.white
        self.drawSize(size: self.view.frame.size)
        
        self.view.addSubview(statusLabel)
        self.view.addSubview(songLabel)
        self.view.addSubview(songProgress)
        self.view.addSubview(indexOfSongLabel)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.drawSize(size: size)
    }
    
    func drawSize(size: CGSize){
        self.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        if((UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) && (size.height < size.width) && (UIScreen.main.scale != 3.0)){
            self.statusLabel.frame = CGRect(x: size.width * 40/100, y: size.height * 10/100, width: size.width * 30/100, height: size.height * 4/100)
        
            self.songLabel.frame = CGRect(x: size.width * 25/100, y: size.height * 20/100, width: size.width * 50/100, height: size.height * 4/100)
        
            self.songProgress.frame = CGRect(x: size.width * 10/100, y: size.height * 30/100, width: size.width * 80/100, height: size.height * 5/100)
        
            self.indexOfSongLabel.frame = CGRect(x: size.width * 40/100, y: size.height * 35/100, width: size.width * 20/100, height: size.height * 4/100)
        }else{
            self.statusLabel.frame = CGRect(x: size.width * 40/100, y: size.height * 10/100, width: size.width * 20/100, height: size.height * 5/100)
            
            self.songLabel.frame = CGRect(x: size.width * 25/100, y: size.height * 20/100, width: size.width * 50/100, height: size.height * 4/100)
            
            self.songProgress.frame = CGRect(x: size.width * 10/100, y: size.height * 30/100, width: size.width * 80/100, height: size.height * 5/100)
            
            self.indexOfSongLabel.frame = CGRect(x: size.width * 40/100, y: size.height * 35/100, width: size.width * 20/100, height: size.height * 4/100)
        }
    }
    
    /****** Functions ******/
    
    func nextSong(){
        statusLabel.text = "Next"
        mediaPlayer.prepareToPlay()
        updateCurrentIndexSong()
        if((mediaPlayer.indexOfNowPlayingItem + 1) != mediaQuery.items?.count){
            mediaPlayer.skipToNextItem()
        }
        isNext = true
        
    }
    
    func prevSong(){
        statusLabel.text = "Previous"
        if(mediaPlayer.isPreparedToPlay==false){
            mediaPlayer.prepareToPlay()
        }else{
            updateCurrentIndexSong()
        }
        if(mediaPlayer.indexOfNowPlayingItem != 0){
            mediaPlayer.skipToPreviousItem()
        }
        
    }
    
    func stopSong(){
        statusLabel.text = "Paused"
        mediaPlayer.pause()
    }
    
    func playSong(){
        statusLabel.text = "Playing"
        mediaPlayer.play()
    }
    
    func songDidChange(){
        var artistName = String()
        if let artist = mediaPlayer.nowPlayingItem?.artist{
            artistName = "\(artist) - "
        }else{
            artistName = ""
        }
        if let title = mediaPlayer.nowPlayingItem?.title{
            songLabel.text = "\(artistName)\(title)"
        }
        
        updateCurrentIndexSong()

        if(mediaPlayer.nowPlayingItem != nil){
            self.delegate?.addSongToHistoric(song: mediaPlayer.nowPlayingItem!)
        }
    }
    
    func playbackStateDidChange(){
        var artistName = String()
        if let artist = mediaPlayer.nowPlayingItem?.artist{
            artistName = "\(artist) - "
        }else{
            artistName = ""
        }
        
        if let title = mediaPlayer.nowPlayingItem?.title{
            songLabel.text = "\(artistName)\(title)"
        }
        
        if(mediaPlayer.playbackState == .playing){
            statusLabel.text = "Playing"
        }
        if(mediaPlayer.playbackState == .stopped){
            statusLabel.text = "Stopped"
        }
        if(mediaPlayer.playbackState == .paused){
            statusLabel.text = "Paused"
        }
        
        updateCurrentIndexSong()
        /*if((UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)){
            if(mediaPlayer.nowPlayingItem != nil){
                //masterVC.addSong(song: mediaPlayer.nowPlayingItem!)
                masterVC.addSongToHistoric(song: mediaPlayer.nowPlayingItem!)
            }
        }else{
            if(mediaPlayer.nowPlayingItem != nil){
                self.delegate?.addSongToHistoric(song: mediaPlayer.nowPlayingItem!)
            }
        }*/
        
        if(mediaPlayer.nowPlayingItem != nil){
            self.delegate?.addSongToHistoric(song: mediaPlayer.nowPlayingItem!)
        }
    }
    
    func updateCurrentIndexSong(){
        if let totalNumberOfSongs = mediaQuery.items?.count{
            if mediaPlayer.indexOfNowPlayingItem != -1 && isBeginning == true{
                indexOfSongLabel.text = "0/\(totalNumberOfSongs)"
                isBeginning = false
            }
           else if isBeginning == false && totalNumberOfSongs != 0{
                indexOfSongLabel.text = "\(mediaPlayer.indexOfNowPlayingItem + 1)/\(totalNumberOfSongs)"
            }
            
        }
    }
    
    func updateSongProgress(){
        if mediaPlayer.playbackState == .playing{
           // songProgress.progress = Float(mediaPlayer.currentPlaybackTime/(mediaPlayer.nowPlayingItem?.playbackDuration)!)
        }
    }
    
    func infoWindow(){
        let infoMessage : UITextView = {
            let message = UITextView()
            message.text = "Play: 1 tap\nStop: 2 tap\nNext: Swipe on left\nPrevious: Swipe on right"
            message.frame = CGRect(x: popover.view.frame.origin.x, y: popover.view.frame.origin.y, width: popover.view.bounds.size.width, height: popover.view.frame.size.height)
            message.font = UIFont.systemFont(ofSize: 20)
            message.isEditable = false
            return message
        }()
        popover.view.addSubview(infoMessage)
        popover.modalPresentationStyle = .popover
        if let presentation = popover.popoverPresentationController{
            presentation.barButtonItem = self.navigationItem.rightBarButtonItem
            presentation.delegate = self
        }
        popover.preferredContentSize = CGSize(width: self.view.frame.size.width * 30/100, height: self.view.frame.size.height * 20/100)
        
        self.present(popover, animated: true, completion: nil)
    }
    
    /****** Protocol UIAdaptivePresentationControllerDelegate ******/
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}



extension myDetailViewController : myMasterViewControllerDelegate{
    func replaySong(song: MPMediaItem) {
        mediaPlayer.nowPlayingItem = song
    }
}
