//
//  myView.swift
//  iSouvenir
//
//  Created by m2sar on 24/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AddressBook
import AddressBookUI

class myView : UIView, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate {

    // Image
    var photoPicker = UIImagePickerController()
    var scrollPhoto = UIScrollView()
    var viewPhoto = UIImageView()
    
    // coordonnée localisation
    var trouver = UIButton()
    var localisation = UILabel()
    var activated : Bool = false
    var lattitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    var altitude = CLLocationDegrees()
    var pinLabel = UILabel()
    var cptPin : Int = 0
    var cptContact : Int = 0
    
    var initialLocation = CLLocation()
    var regionRadius : CLLocationDistance = 1000
    
    //toolBar
    var myTB = UIToolbar()
    var myTBItems = [UIBarButtonItem]()
    var add = UIBarButtonItem()
    var trash = UIBarButtonItem()
    var empty = UIBarButtonItem()
    var refresh = UIBarButtonItem()
    var book = UIBarButtonItem()
    var cam = UIBarButtonItem()
    var gallery = UIBarButtonItem()
    var labelItem = UIBarButtonItem()
    
    //map
    var selectAnnotation = MKPointAnnotation()
    var locManager = CLLocationManager()
    var actLocation = CLLocationCoordinate2D()
    var mapView = MKMapView()
    var segment = UISegmentedControl()
    var targetView = UIImageView()
    var camera = MKMapCamera()
    
    var annotationTable = [MKAnnotation]()
    var selectedAnnotation : MKAnnotation!
    
    //Initialisation
    override init(frame : CGRect) {
        super.init(frame : frame)
        
        trouver = UIButton(type: .system)
        localisation.text = ""
        initialLocation = CLLocation(latitude: 48.8737793, longitude: 2.2928269)
        
        pinLabel.text = "Pins: "
        
        add = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(addAction));
        trash = UIBarButtonItem(barButtonSystemItem: .trash , target: self, action: #selector(trashAction));
        empty = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
        refresh = UIBarButtonItem(barButtonSystemItem: .refresh , target: self, action: #selector(refreshAction));
        book = UIBarButtonItem(barButtonSystemItem: .bookmarks , target: self, action: #selector(bookAction));
        cam = UIBarButtonItem(barButtonSystemItem: .camera , target: self, action: #selector(camAction));
        gallery = UIBarButtonItem(barButtonSystemItem: .organize , target: self, action: #selector(galleryAction));
        
        myTB.alpha = 0.9
        
        
        //toolBar
        myTBItems.append(add)
        myTBItems.append(trash)
        myTBItems.append(empty)
        myTBItems.append(refresh)
        myTBItems.append(book)
        myTBItems.append(cam)
        myTBItems.append(gallery)
        //myTBItems.append(labelItem)
        myTB.setItems(myTBItems, animated: true)
        
        trash.isEnabled = false
        book.isEnabled = false
        cam.isEnabled = false
        gallery.isEnabled = false
        
        //map
        //selectAnnotation = nil
        locManager.distanceFilter = 1.0
        locManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locManager.requestAlwaysAuthorization()
        locManager.startUpdatingLocation()
        
        mapView = MKMapView(frame: frame)
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        mapView.showsUserLocation = true
        mapView.isPitchEnabled = true
        mapView.mapType = MKMapType.standard
        mapView.showsBuildings = true
        mapView.camera.pitch = 45.0
        mapView.camera.heading = 50.0
        mapView.camera.altitude = 500.0
        
        
        segment = UISegmentedControl(items: ["3D", "Carte", "Satellite", "Hybride"])
        segment.addTarget(self, action: #selector(changeMapType), for: UIControlEvents.valueChanged)
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = UIColor.white
        
        targetView = UIImageView(image: UIImage(named: "target"))
        
        mapView.delegate = self
        
        //trouver.addTarget(self, action: #selector(calculPosition), for: .touchDown)
        
        centerMapOnLocation(location: initialLocation)
        
        //Ajout à la view
        addSubview(mapView)
        addSubview(segment)
        addSubview(targetView)
        addSubview(myTB);
        addSubview(localisation)
        addSubview(pinLabel)
        addSubview(scrollPhoto)
        addSubview(viewPhoto)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Dessiner la view
    override func draw(_ rect: CGRect) {
        self.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height);
        
        myTB.frame = CGRect(x: 0, y: rect.size.height * 90/100, width: rect.size.width, height: rect.size.height * 10/100)
        
        segment.frame = CGRect(x: rect.size.width * 20/100, y: rect.size.height * 4/100, width: rect.size.width * 60/100, height: rect.size.height * 4/100)
        
        mapView.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        
        localisation.frame = CGRect(x: 0, y: rect.size.height * 90/100, width: rect.size.width * 70/100, height: rect.size.height * 2/100)
        localisation.font = UIFont(name: localisation.font.fontName, size: 12)
        localisation.backgroundColor = UIColor.clear
        localisation.textAlignment = .center
        
        pinLabel.frame = CGRect(x: rect.size.width * 70/100, y: rect.size.height * 90/100, width: rect.size.width * 30/100, height: rect.size.height * 2/100)
        pinLabel.font = UIFont(name: localisation.font.fontName, size: 12)
        pinLabel.backgroundColor = UIColor.clear
        pinLabel.textAlignment = .center
    }
    
    
    
    //Gestion de la rotation et redimensionnement (cas du Split)
    
    
    //Actions
    func addAction(){
        cptPin += 1
        cptContact += 1
        var newPin = myAnnotation(c: mapView.centerCoordinate, t: "Contact \(cptContact)", st: "Pas de contact")
        pinLabel.text = "Pins: \(cptPin)"
        mapView.addAnnotation(newPin)
        //annotationTable.append(newPin)
    }
    

    func trashAction(){
        //mapView.removeAnnotation(selectAnnotation)
        mapView.removeAnnotations(annotationTable)
        localisation.text = ""
        if(cptPin > 0){
            cptPin -= 1
        }
        pinLabel.text = "Pins: \(cptPin)"
    }
    
    func refreshAction(){
        if activated{
            activated = false
            locManager.stopUpdatingLocation()
            locManager.stopUpdatingHeading()
            localisation.text = "Pin on \(locManager.location?.coordinate.latitude), \(locManager.location?.coordinate.longitude)"
        }else{
            locManager.delegate = self
            locManager.distanceFilter = kCLLocationAccuracyBest
            locManager.startUpdatingLocation()
            
            if CLLocationManager.headingAvailable(){
                locManager.startUpdatingLocation()
            }
            activated = true
        }
        localisation.text = ""
    }
    
    func bookAction(){
    
        localisation.text = ""
    }
    
    func camAction(){
        localisation.text = ""
    }
    
    func galleryAction(){
        photoPicker.delegate = self
        photoPicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        photoPicker.allowsEditing = true
        
        var vController = UIViewController()
        vController.present(photoPicker, animated: true, completion: nil)
        localisation.text = ""
    }
    
    func changeMapType(){
        var currentRegion = mapView.region
        
        if(segment.selectedSegmentIndex == 0){
            mapView.showsBuildings = true
            mapView.isPitchEnabled = true
            mapView.camera.pitch = 45.0
            mapView.camera.heading = 50.0
            mapView.camera.altitude = 500.0
        }
        if(segment.selectedSegmentIndex == 1){
            mapView.mapType = MKMapType.standard
            mapView.showsBuildings = false
            mapView.isPitchEnabled = false
        }
        if(segment.selectedSegmentIndex == 2){
            mapView.mapType = MKMapType.satelliteFlyover
            mapView.showsBuildings = false
            mapView.isPitchEnabled = false
        }
        if(segment.selectedSegmentIndex == 3){
            mapView.mapType = MKMapType.hybridFlyover
            mapView.showsBuildings = false
            mapView.isPitchEnabled = false
        }
        if(camera != nil && mapView != nil){
            mapView.setCamera(camera, animated: true)
        }
        mapView.setRegion(currentRegion, animated: true)
        
        localisation.text = segment.selectedSegmentIndex.description
    }
    
    /*
    func updateDistanceToAnnotation(annotation: MKAnnotation){
        if (annotation == nil){
            distLabel.text = "No annotation selected";
            return;
        }
    
        if (mapView.userLocation.location == nil){
            distLabel.text = "User location is unknown";
            return;
        }
    
        var pinLocation = CLLocation()
            initWithLatitude:annotation.coordinate.latitude
            longitude:annotation.coordinate.longitude];
    
        CLLocation *userLocation = [[CLLocation alloc]
            initWithLatitude:mapView.userLocation.coordinate.latitude
            longitude:mapView.userLocation.coordinate.longitude];
    
        CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    
        [distLabel setText: [NSString stringWithFormat:@"Distance to point %4.0f m.", distance]];
    }*/
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var coordinateLocation = locManager.location?.coordinate
        var coordinateRegion = MKCoordinateRegion()
        var annotation : myAnnotation
        
        coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinateLocation!, regionRadius * 2.0, regionRadius * 2.0)
        annotation = myAnnotation(c: coordinateLocation!, t: String(format: "Contact %d", cptPin), st: "Pas de contact")
        
        cptPin += 1
        localisation.text = "Pin on \(locManager.location?.coordinate.latitude), \(locManager.location?.coordinate.longitude)"
        pinLabel.text = "Pins : \(cptPin)"
        mapView.addAnnotation(annotation)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        localisation.text = "Echec: " + error.localizedDescription
        locManager.stopUpdatingLocation()
        locManager.stopUpdatingHeading()
        trouver.setTitle("Cherche moi", for: UIControlState())
        activated = false
    }
    
    func centerMapOnLocation(location: CLLocation){
        var coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 1000.0, regionRadius * 1000.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        pin.canShowCallout = true
        pin.leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        localisation.text = "Pin on \(view.annotation?.coordinate.latitude), \(view.annotation?.coordinate.longitude)"
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        trash.isEnabled = true
        book.isEnabled = true
        cam.isEnabled = true
        gallery.isEnabled = true
        
        annotationTable.append(view.annotation!)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        trash.isEnabled = false
        book.isEnabled = false
        cam.isEnabled = false
        gallery.isEnabled = false
        localisation.text = ""
        
        annotationTable.removeFirst()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewPhoto.contentMode = .scaleAspectFit
            viewPhoto.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollPhoto
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoomScale = scale
    }
}
