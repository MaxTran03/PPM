//
//  ViewController.m
//  DizainierC
//
//  Created by m2sar on 28/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

int labelValue = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _stepperOutlet.minimumValue = 0;
    _stepperOutlet.maximumValue = 99;
    [_switchOutlet setOn:false];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)stepperAction:(id)sender {
    [_dizaineOutlet setSelectedSegmentIndex:_stepperOutlet.value / 10];
    [_uniteOutlet setSelectedSegmentIndex:fmod(_stepperOutlet.value,10)];
    [_slider setValue:_stepperOutlet.value];
    labelValue = _stepperOutlet.value;
    [self updateLabel];
}

- (IBAction)RaZ:(id)sender {
    [_stepperOutlet setValue:0];
    [_dizaineOutlet setSelectedSegmentIndex:0];
    [_uniteOutlet setSelectedSegmentIndex:0];
    [_slider setValue:0];
    labelValue = _stepperOutlet.value;
    [self updateLabel];
}

- (IBAction)sliderAction:(id)sender {
    [_stepperOutlet setValue:_slider.value];
    [_dizaineOutlet setSelectedSegmentIndex:_slider.value / 10];
    [_uniteOutlet setSelectedSegmentIndex:fmod(_slider.value,10)];
    labelValue = _slider.value;
    [self updateLabel];
}

- (IBAction)dizaineSegment:(id)sender {
    labelValue = (roundf(_dizaineOutlet.selectedSegmentIndex) * 10) + _uniteOutlet.selectedSegmentIndex;
    [_stepperOutlet setValue:labelValue];
    [_slider setValue:labelValue];
    [self updateLabel];
}

- (IBAction)uniteSegment:(id)sender {
    labelValue = (roundf(_dizaineOutlet.selectedSegmentIndex) * 10) + _uniteOutlet.selectedSegmentIndex;
    [_stepperOutlet setValue:labelValue];
    [_slider setValue:labelValue];
    [self updateLabel];
}

- (IBAction)switchAction:(id)sender {
    [self updateLabel];
}

- (void) updateLabel{
    if(_switchOutlet.on){
        [_labelAffiche setTextColor: [UIColor redColor]];
        _labelAffiche.text = [NSString stringWithFormat:@"%x", (int)labelValue];
    }else{
        [_labelAffiche setTextColor: [UIColor blackColor]];
        _labelAffiche.text = [NSString stringWithFormat:@"%d", labelValue];
    }
}

@end
