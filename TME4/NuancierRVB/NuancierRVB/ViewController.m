//
//  ViewController.m
//  NuancierRVB
//
//  Created by m2sar on 24/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import "ViewController.h"
#import "MaVue.h"

@interface ViewController ()

@end

@implementation ViewController

MaVue *v;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    v = [[MaVue alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [v setBackgroundColor:[UIColor whiteColor]];
    [self setView:v];
    
    [v.penultiemeBouton addTarget:self action:@selector(penultiemeAction:) forControlEvents:UIControlEventTouchDown];
    [v.precedentBouton addTarget:self action:@selector(precedentAction:) forControlEvents:UIControlEventTouchDown];
    [v.remiseAZero addTarget:self action:@selector(RaZ:) forControlEvents:UIControlEventTouchDown];
    [v.sauvegarder addTarget:self action:@selector(memoriser:) forControlEvents:UIControlEventTouchDown];
    [v.sliderR addTarget:self action:@selector(sliderRAction:) forControlEvents:UIControlEventValueChanged];
    [v.sliderV addTarget:self action:@selector(sliderVAction:) forControlEvents:UIControlEventValueChanged];
    [v.sliderB addTarget:self action:@selector(sliderBAction:) forControlEvents:UIControlEventValueChanged];
    [v.switchMode addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    
    [v.sliderR setMinimumValue:0.0];
    [v.sliderR setMaximumValue:255.0];
    
    [v.sliderV setMinimumValue:0.0];
    [v.sliderV setMaximumValue:255.0];
    
    [v.sliderB setMinimumValue:0.0];
    [v.sliderB setMaximumValue:255.0];
    
    [v.sliderR setValue: 256/2];
    [v.sliderV setValue: 256/2];
    [v.sliderB setValue: 256/2];
    
    UIColor * newColor = [UIColor colorWithRed:v.sliderR.value/255 green:v.sliderV.value/255 blue:v.sliderB.value/255 alpha:1];
    
    [v.penultiemeBouton setBackgroundColor:newColor];
    [v.precedentBouton setBackgroundColor:newColor];
    [v.actuelCouleur setBackgroundColor:newColor];
    
    [v.labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (v.sliderR.value*100)/255]];
    [v.labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (v.sliderV.value*100)/255]];
    [v.labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (v.sliderB.value*100)/255]];
    
    [v.switchMode setOn:false];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)penultiemeAction:(UIButton *)sender {
    [v.actuelCouleur setBackgroundColor: v.penultiemeBouton.backgroundColor];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    UIColor *bgColor = v.actuelCouleur.backgroundColor;
    
    [bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    [v.sliderR setValue:red*255];
    [v.sliderV setValue:green*255];
    [v.sliderB setValue:blue*255];

    [self affichage];
}

- (void)precedentAction:(UIButton *)sender {
    [v.actuelCouleur setBackgroundColor:v.precedentBouton.backgroundColor];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    UIColor *bgColor = v.actuelCouleur.backgroundColor;
    
    [bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    [v.sliderR setValue:red*255];
    [v.sliderV setValue:green*255];
    [v.sliderB setValue:blue*255];
    
    [self affichage];
}

- (void)switchAction:(UISwitch *)sender {
    [v.sliderR setValue : roundf(v.sliderR.value/255*10)*255/10];
    [v.sliderV setValue : roundf(v.sliderV.value/255*10)*255/10];
    [v.sliderB setValue : roundf(v.sliderB.value/255*10)*255/10];
    
    [self affichage];
}

- (void)RaZ:(UIButton *)sender {
    [v.sliderR setValue: 256/2];
    [v.sliderV setValue: 256/2];
    [v.sliderB setValue: 256/2];
    
    UIColor * newColor = [UIColor colorWithRed:v.sliderR.value/255 green:v.sliderV.value/255 blue:v.sliderB.value/255 alpha:1];
    
    [v.actuelCouleur setBackgroundColor:newColor];
    
    [self affichage];
}

- (void)memoriser:(UIButton *)sender {
    [v.penultiemeBouton setBackgroundColor:v.precedentBouton.backgroundColor];
    [v.precedentBouton setBackgroundColor:v.actuelCouleur.backgroundColor];
}

- (void) sliderRAction:(UISlider *)sender {
    if(v.switchMode.isOn)
        v.sliderR.value = roundf(v.sliderR.value/255*10)*255/10;
    
    v.sliderR = (UISlider *) sender;
    UIColor * newColor = [UIColor colorWithRed:v.sliderR.value/255 green:v.sliderV.value/255 blue:v.sliderB.value/255 alpha:1];
    
    [v.actuelCouleur setBackgroundColor:newColor];
    [v.labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (v.sliderR.value*100)/255]];

}

- (void) sliderVAction:(UISlider *)sender {
    if(v.switchMode.isOn)
        v.sliderV.value = roundf(v.sliderV.value/255*10)*255/10;
    
    v.sliderV = (UISlider *) sender;
    UIColor * newColor = [UIColor colorWithRed:v.sliderR.value/255 green:v.sliderV.value/255 blue:v.sliderB.value/255 alpha:1];
    
    [v.actuelCouleur setBackgroundColor:newColor];
    [v.labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (v.sliderV.value*100)/255]];
}

- (void) sliderBAction:(UISlider *)sender {
    if(v.switchMode.isOn)
        v.sliderB.value = roundf(v.sliderB.value/255*10)*255/10;
    
    v.sliderB = (UISlider *) sender;
    UIColor * newColor = [UIColor colorWithRed:v.sliderR.value/255 green:v.sliderV.value/255 blue:v.sliderB.value/255 alpha:1];
    
    [v.actuelCouleur setBackgroundColor:newColor];
    [v.labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (v.sliderB.value*100)/255]];
}

- (void) affichage{
    [v.labelR setText:[NSString stringWithFormat:@"R : %0.0f%%", (v.sliderR.value*100)/255]];
    [v.labelV setText:[NSString stringWithFormat:@"V : %0.0f%%", (v.sliderV.value*100)/255]];
    [v.labelB setText:[NSString stringWithFormat:@"B : %0.0f%%", (v.sliderB.value*100)/255]];
}

@end
