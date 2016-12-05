//
//  MaVue.swift
//  MiniNav
//
//  Created by m2sar on 28/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import UIKit

class MaVue : UIView, UIWebViewDelegate {
    let navBar = UIToolbar()
    
    let homePreference = UIAlertController(title: nil, message: "Confirmer le changement ?", preferredStyle: .actionSheet)
    
    let changeURL = UIAlertController(title: "URL", message: "Entrez une URL à charger", preferredStyle: .alert)
    
    let changeHome = UIAlertController(title: "URL maison", message: "Entrez l'URL par défaut", preferredStyle: .alert)
    
    let activityIndicator = UIActivityIndicatorView()
    
    var answerURL = UITextField()
    var homeURL = UITextField()
    
    let webView = UIWebView()
    
    // Create button
    let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: nil, action: nil)
    
    let previousButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.rewind, target: nil, action: nil)
    
    let changeUrlButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: nil, action: nil)
    
    let nextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fastForward, target: nil, action: nil)
    
    let homePreferenceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: nil, action:nil)
    
    let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    
    let fixed = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
    
    
    
    override init (frame: CGRect){
        super.init(frame: frame)
        
        fixed.width = 20.0
        
        activityIndicator.color = UIColor.red
        
        navBar.items = [refreshButton, flexible, previousButton, fixed, changeUrlButton, fixed, nextButton, flexible, homePreferenceButton]
        navBar.barTintColor = UIColor.lightGray
        
        refreshButton.target = self.superview
        previousButton.target = self.superview
        changeUrlButton.target = self.superview
        nextButton.target = self.superview
        homePreferenceButton.target = self.superview
        
        refreshButton.action = #selector(ViewController.refreshURL)
        previousButton.action = #selector(ViewController.navigationBar)
        changeUrlButton.action = #selector(ViewController.newURL)
        nextButton.action = #selector(ViewController.navigationBar)
        homePreferenceButton.action = #selector(ViewController.validatePreference)
        
        self.addSubview(webView)
        self.addSubview(navBar)
        self.addSubview(activityIndicator)
        
        drawInFormat(format: frame.size)
        
        webView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawInFormat(format: CGSize){
        /*var top = 0
        if(format.width > format.height){
            top = 0
        }else{
            top = 10
        }*/
        
        navBar.frame = CGRect(x: 0,
                              y: 0,
                              width: Int(format.width),
                              height: Int(format.height * 10/100))
        
        activityIndicator.frame = CGRect(x: Int(format.width) * 15/100,
                                         y: Int(format.height) * 3/100,
                                         width: Int(format.width) * 5/100,
                                         height: Int(format.height) * 4/100)
        
        webView.frame = CGRect(x: 0,
                               y: Int(navBar.bounds.size.height),
                               width: Int(format.width),
                               height: Int(format.height - navBar.bounds.size.height))
    }
    
    
    func loadURL(url: String){
        webView.loadRequest(URLRequest(url: URL(string: url)!))
    }
    
    func forwardInWebView(){
        if(webView.canGoForward){
            webView.goForward()
            previousButton.isEnabled = true
        }else{
            nextButton.isEnabled = false
        }
    }
    
    func backwardInWebView(){
        if(webView.canGoBack){
            webView.goBack()
            nextButton.isEnabled = true
        }else{
            previousButton.isEnabled = false
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        nextButton.isEnabled = webView.canGoForward
        previousButton.isEnabled = webView.canGoBack
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        let errorVC = UIAlertController(title: "Erreur", message: error.localizedDescription, preferredStyle: .alert)
        errorVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.windows[0].rootViewController?.present(errorVC, animated: true, completion: {})
    }
}

