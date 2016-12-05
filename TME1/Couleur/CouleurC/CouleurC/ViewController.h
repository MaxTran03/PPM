//
//  ViewController.h
//  CouleurC
//
//  Created by m2sar on 21/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)stepperButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *ViewWindow;
@property (weak, nonatomic) IBOutlet UIStepper *stepperOutlet;

@end

