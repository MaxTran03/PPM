//
//  ViewController.h
//  DizainierC
//
//  Created by m2sar on 28/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (assign, nonatomic) IBOutlet UIStepper *stepperOutlet;
@property (assign, nonatomic) IBOutlet UILabel *labelAffiche;
@property (assign, nonatomic) IBOutlet UISegmentedControl *uniteOutlet;
@property (assign, nonatomic) IBOutlet UISegmentedControl *dizaineOutlet;
@property (assign, nonatomic) IBOutlet UISlider *slider;
@property (assign, nonatomic) IBOutlet UISwitch *switchOutlet;


- (IBAction)stepperAction:(id)sender;

- (IBAction)RaZ:(id)sender;

- (IBAction)sliderAction:(id)sender;

- (IBAction)dizaineSegment:(id)sender;

- (IBAction)uniteSegment:(id)sender;

- (IBAction)switchAction:(id)sender;

- (void) updateLabel;

@end

