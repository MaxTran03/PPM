//
//  ViewController.m
//  NuancierRVB
//
//  Created by m2sar on 30/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_sliderROutlet setMinimumValue:0.0];
    [_sliderROutlet setMaximumValue:255.0];
    
    [_sliderVOutlet setMinimumValue:0.0];
    [_sliderVOutlet setMaximumValue:255.0];
    
    [_sliderBOutlet setMinimumValue:0.0];
    [_sliderBOutlet setMaximumValue:255.0];
    
    [_labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", _sliderROutlet.value]];
    [_labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", _sliderVOutlet.value]];
    [_labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", _sliderBOutlet.value]];
    
    [_switchOutlet setOn:false];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sliderRAction:(id)sender {
    if(_switchOutlet.isOn)
        _sliderROutlet.value = roundf(_sliderROutlet.value/255*10)*255/10;
    
    _sliderROutlet = (UISlider *) sender;
    UIColor * newColor = [UIColor colorWithRed:_sliderROutlet.value/255 green:_sliderVOutlet.value/255 blue:_sliderBOutlet.value/255 alpha:1];
    
    [_actuelOutlet setBackgroundColor:newColor];
    [_labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (_sliderROutlet.value*100)/255]];
    
}
    
- (IBAction)sliderVAction:(id)sender {
    if(_switchOutlet.isOn)
        _sliderVOutlet.value = roundf(_sliderVOutlet.value/255*10)*255/10;
    
    _sliderVOutlet = (UISlider *) sender;
    UIColor * newColor = [UIColor colorWithRed:_sliderROutlet.value/255 green:_sliderVOutlet.value/255 blue:_sliderBOutlet.value/255 alpha:1];
    
    [_actuelOutlet setBackgroundColor:newColor];
    [_labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (_sliderVOutlet.value*100)/255]];
}

- (IBAction)sliderBAction:(id)sender {
    if(_switchOutlet.isOn)
        _sliderBOutlet.value = roundf(_sliderBOutlet.value/255*10)*255/10;
    
    _sliderBOutlet = (UISlider *) sender;
    UIColor * newColor = [UIColor colorWithRed:_sliderROutlet.value/255 green:_sliderVOutlet.value/255 blue:_sliderBOutlet.value/255 alpha:1];
    
    [_actuelOutlet setBackgroundColor:newColor];
    [_labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (_sliderBOutlet.value*100)/255]];
}

- (IBAction)memoriser:(id)sender {
    [_penultiemeOutlet setBackgroundColor:_precedentOutlet.backgroundColor];
    [_precedentOutlet setBackgroundColor:_actuelOutlet.backgroundColor];
}

- (IBAction)RaZ:(id)sender {
    [_sliderROutlet setValue: 256/2];
    [_sliderVOutlet setValue: 256/2];
    [_sliderBOutlet setValue: 256/2];
    
    [_labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (_sliderROutlet.value*100)/255]];
    [_labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (_sliderVOutlet.value*100)/255]];
    [_labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (_sliderBOutlet.value*100)/255]];
}

- (IBAction)switchAction:(id)sender {
    [_sliderROutlet setValue : roundf(_sliderROutlet.value/255*10)*255/10];
    [_sliderVOutlet setValue : roundf(_sliderVOutlet.value/255*10)*255/10];
    [_sliderBOutlet setValue : roundf(_sliderBOutlet.value/255*10)*255/10];
    
    [_labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (_sliderROutlet.value*100)/255]];
    [_labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (_sliderVOutlet.value*100)/255]];
    [_labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (_sliderBOutlet.value*100)/255]];
}

- (IBAction)penultiemeAction:(id)sender {
    
    [_actuelOutlet setBackgroundColor:_penultiemeOutlet.backgroundColor];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    UIColor *bgColor = _actuelOutlet.backgroundColor;
    
    [bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    [_sliderROutlet setValue:red*255];
    [_sliderVOutlet setValue:green*255];
    [_sliderBOutlet setValue:blue*255];

    [_labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (_sliderROutlet.value*100)/255]];
    [_labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (_sliderVOutlet.value*100)/255]];
    [_labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (_sliderBOutlet.value*100)/255]];
    
}

- (IBAction)precedentAction:(id)sender {
    
    [_actuelOutlet setBackgroundColor:_precedentOutlet.backgroundColor];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    UIColor *bgColor = _actuelOutlet.backgroundColor;
    
    [bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    [_sliderROutlet setValue:red*255];
    [_sliderVOutlet setValue:green*255];
    [_sliderBOutlet setValue:blue*255];
    
    [_labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (_sliderROutlet.value*100)/255]];
    [_labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (_sliderVOutlet.value*100)/255]];
    [_labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (_sliderBOutlet.value*100)/255]];
}

@end
