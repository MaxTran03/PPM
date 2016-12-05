//
//  myContact.swift
//  iSouvenir
//
//  Created by m2sar on 24/11/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class myContact
{
    var number : Int!
    var name : NSString!
    var description : NSString!
    var photo : UIImage!
    var position : CLLocationCoordinate2D!
    
    func myInit(num : Int, nam : NSString)
    {
        number = num;
        name = NSString(string: nam);
        description = NSString();
        description = "Contact \(number)" as NSString!;
        photo = UIImage();
        position = CLLocationCoordinate2D();
    }
}
