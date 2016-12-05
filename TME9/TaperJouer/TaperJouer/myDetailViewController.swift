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

class myDetailViewController : ViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate, MPMediaPickerControllerDelegate{
    
    var statusLabel = UILabel()
    var songLabel = UILabel()
    var songProgress = UIProgressView()
    var indexOfSongLabel = UILabel()
    
    var mediaPlayer = MPMusicPlayerController()
    var mediaPicker = MPMediaPickerController()
    
    var nextSongOnSwipeLeft = UISwipeGestureRecognizer()
    var prevSongOnSwipeRight = UISwipeGestureRecognizer()
    var stopSongOnDoubleTap = UITapGestureRecognizer()
    var playSongOnSingleTap = UITapGestureRecognizer()
    
    var songsArray = [MPMediaItem]()
    var mediaQuery = MPMediaQuery()
    
    var notificationCenter = NotificationCenter()
    
    weak var delegate : myDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Music"
        
        statusLabel.text = "Stopped"
        statusLabel.textAlignment = .center
        
        songLabel.text = ""
        songLabel.textAlignment = .center
        
        songProgress.progress = 0
        
        indexOfSongLabel.text = "0/0"
        indexOfSongLabel.textAlignment = .center
        
        mediaPlayer = MPMusicPlayerController.applicationMusicPlayer()
        mediaPicker.delegate = self
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: .MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        
        mediaPlayer.setQueue(with: mediaQuery)
        
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
            self.statusLabel.frame = CGRect(x: size.width * 40/100, y: size.height * 10/100, width: size.width * 20/100, height: size.height * 4/100)
        
            self.songLabel.frame = CGRect(x: size.width * 25/100, y: size.height * 20/100, width: size.width * 50/100, height: size.height * 4/100)
        
            self.songProgress.frame = CGRect(x: size.width * 10/100, y: size.height * 30/100, width: size.width * 80/100, height: size.height * 5/100)
        
            self.indexOfSongLabel.frame = CGRect(x: size.width * 45/100, y: size.height * 35/100, width: size.width * 10/100, height: size.height * 4/100)
        }else{
            self.statusLabel.frame = CGRect(x: size.width * 40/100, y: size.height * 10/100, width: size.width * 20/100, height: size.height * 4/100)
            //self.statusLabel.backgroundColor = UIColor.white
            
            self.songLabel.frame = CGRect(x: size.width * 25/100, y: size.height * 20/100, width: size.width * 50/100, height: size.height * 4/100)
            //self.songLabel.backgroundColor = UIColor.white
            
            self.songProgress.frame = CGRect(x: size.width * 10/100, y: size.height * 30/100, width: size.width * 80/100, height: size.height * 5/100)
            
            self.indexOfSongLabel.frame = CGRect(x: size.width * 45/100, y: size.height * 35/100, width: size.width * 10/100, height: size.height * 4/100)
        }
    }
    
    /****** Protocole MPMediaPickerControllerDelegate ******/
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        mediaPicker.dismiss(animated: true, completion: nil)
        mediaPlayer.setQueue(with: mediaItemCollection)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: .MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        mediaPlayer.play()
        mediaPlayer.beginGeneratingPlaybackNotifications()
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
        mediaPlayer.stop()
    }
    
    /****** Functions ******/
    
    func nextSong(){
        songLabel.text = "\(mediaPlayer.nowPlayingItem?.artist) - \(mediaPlayer.nowPlayingItem?.title)"
        indexOfSongLabel.text = "\(mediaPlayer.indexOfNowPlayingItem)/\(mediaQuery.items?.count)"
        mediaPlayer.skipToNextItem()
        if(mediaPlayer.nowPlayingItem != nil){
            self.delegate?.addSongToHistoric(song: mediaPlayer.nowPlayingItem!)
        }
    }
    
    func prevSong(){
        songLabel.text = "\(mediaPlayer.nowPlayingItem?.artist) - \(mediaPlayer.nowPlayingItem?.title)"
        indexOfSongLabel.text = "\(mediaPlayer.indexOfNowPlayingItem)/\(mediaQuery.items?.count)"
        mediaPlayer.skipToPreviousItem()
        if(mediaPlayer.nowPlayingItem != nil){
            self.delegate?.addSongToHistoric(song: mediaPlayer.nowPlayingItem!)
        }
    }
    
    func stopSong(){
        statusLabel.text = "Stopped"
        mediaPlayer.stop()
    }
    
    func playSong(){
        statusLabel.text = "Listening"
        mediaPlayer.play()
    }
    
    func updateLabel(){
        songLabel.text = "\(mediaPlayer.nowPlayingItem?.artist) - \(mediaPlayer.nowPlayingItem?.title)"
    }
}

extension myDetailViewController : myMasterViewControllerDelegate{
    func replaySong(song: MPMediaItem) {
        
    }
}
