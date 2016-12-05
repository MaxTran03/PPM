//
//  ViewController.m
//  CouleurC
//
//  Created by m2sar on 21/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray* colorTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    colorTable = [ NSArray arrayWithObjects: [UIColor whiteColor], [UIColor blackColor], [UIColor yellowColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
    [_stepperOutlet setMinimumValue:0.0];
    [_stepperOutlet setMaximumValue:5.0];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)stepperButton:(id)sender {
    [_ViewWindow setBackgroundColor: colorTable[(int)_stepperOutlet.value]];
}

@end
