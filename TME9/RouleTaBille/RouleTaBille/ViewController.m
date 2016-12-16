//
//  ViewController.m
//  RouleTaBille
//
//  Created by Max Corp on 12/4/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _backgroundImageArray = [[NSArray alloc] initWithObjects:@"rouletabille-fond-eau", @"rouletabille-fond-mosaique", @"rouletabille-fond-phobos", @"rouletabille-fond-voutes", nil];
    
    _indexImageArray = 0;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:_backgroundImageArray[_indexImageArray]]];
    
    [self becomeFirstResponder];
    
    _startGameV = [[StartGameView alloc]init];
    _endGameV = [[EndGameView alloc] init];
    
    _startGameV.delegate = self;
    _endGameV.delegate = self;
    
    [self.view addSubview:_startGameV];
    [self.view addSubview:_endGameV];
    
    [_backgroundImageArray release];
    [_startGameV release];
    [_endGameV release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

/*
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}*/

- (BOOL)shouldAutorotate{
    return NO;
}

/****** UIResponder ******/
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake){
        [self nextBackgroundImageOnShake];
    }
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

/****** Functions ******/
- (void)nextBackgroundImageOnShake{
    _indexImageArray = (_indexImageArray + 1) % _backgroundImageArray.count;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:_backgroundImageArray[_indexImageArray]]];
}

- (void)startGame{
    
}

/****** Protocol StartGameViewDelegate ******/
- (void)shouldStartGame{
    [_startGameV hideView];
    [self startGame];
}

/****** Protocol EndGameViewDelegate ******/
- (void)displayWithScore:(int)score{
    
}

@end
