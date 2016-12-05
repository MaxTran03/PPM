//
//  ViewController.h
//  NuancierRVB
//
//  Created by m2sar on 30/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *penultiemeOutlet;
@property (nonatomic, retain) IBOutlet UIButton *precedentOutlet;
@property (nonatomic, retain) IBOutlet UIView *actuelOutlet;
@property (nonatomic, retain) IBOutlet UILabel *labelR;
@property (nonatomic, retain) IBOutlet UILabel *labelV;
@property (nonatomic, retain) IBOutlet UILabel *labelB;
@property (nonatomic, retain) IBOutlet UISwitch *switchOutlet;

@property (nonatomic, retain) IBOutlet UISlider *sliderROutlet;
@property (nonatomic, retain) IBOutlet UISlider *sliderVOutlet;
@property (nonatomic, retain) IBOutlet UISlider *sliderBOutlet;

- (IBAction)sliderRAction:(id)sender;
- (IBAction)sliderVAction:(id)sender;
- (IBAction)sliderBAction:(id)sender;
- (IBAction)memoriser:(id)sender;
- (IBAction)RaZ:(id)sender;
- (IBAction)switchAction:(id)sender;

- (IBAction)penultiemeAction:(id)sender;
- (IBAction)precedentAction:(id)sender;

@end

