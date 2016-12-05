//
//  ViewController.m
//  Imagier
//
//  Created by m2sar on 28/10/2016.
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
    
    [v.sliderScroll addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    [v.next setAction:@selector(navigationAction:)];
    [v.previous setAction:@selector(navigationAction:)];
    
    v.i = 0;
    
    [v.sliderScroll setValue:0.2];
    [v.scroll setZoomScale:0.0 animated:YES];
    [v.percent setText:[NSString stringWithFormat:@"%0.f%%", v.sliderScroll.value*100]];
    [v.imageName setText:[NSString stringWithFormat:@"%@",v.imageArray[0]]];
    [v.toolBar setBarTintColor:[UIColor whiteColor]];
    
    [v release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) sliderAction: (UISlider *)sender{
    [v.scroll setZoomScale:sender.value];
    [v.percent setText:[NSString stringWithFormat:@"%0.f%%", v.sliderScroll.value*100]];
}

- (IBAction) navigationAction: (UIBarButtonItem *)sender {
    if(sender == v.previous){
        if(v.i > 0){
            v.i--;
        }else{
            v.i = v.maxArray - 1;
        }
    }else{
        if(v.i < v.maxArray - 1){
            v.i++;
        }else{
            v.i = 0;
        }
    }
    
    [v.sliderScroll setValue:v.imagePercent[v.i].floatValue];
    [v.percent setText:[NSString stringWithFormat:@"%0.f%%", v.sliderScroll.value*100]];
    
    [v.imageView removeFromSuperview];
    v.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:v.imageArray[v.i]]];
    
    [v.scroll setZoomScale:v.imagePercent[v.i].floatValue];
    
    [v.scroll addSubview:v.imageView];
    [v.imageName setText:v.imageArray[v.i]];
    
}

/*
- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [v drawInFormat:size];
}*/

@end
