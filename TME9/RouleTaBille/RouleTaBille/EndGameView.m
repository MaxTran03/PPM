//
//  EndGameView.m
//  RouleTaBille
//
//  Created by Max Corp on 12/11/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EndGameView.h"

@implementation EndGameView

- (instancetype)init{
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect frame = CGRectMake(screenWidth * 5/100, screenHeight/2 - screenHeight * 15/100, screenWidth * 90/100, screenHeight * 30/100);
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = [UIColor grayColor];
        
        _congratulationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, screenWidth * 90/100, screenHeight * 5/100)];
        _congratulationLabel.textAlignment = NSTextAlignmentCenter;
        _congratulationLabel.textColor = [UIColor whiteColor];
        _congratulationLabel.text = [NSString stringWithFormat:@"Congratulation !"];
        //_congratulationLabel.backgroundColor = [UIColor blueColor];
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + screenHeight * 5/100 + screenHeight + 2/100, screenWidth * 90/100, screenHeight * 10/100)];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
        _scoreLabel.font = [_scoreLabel.font fontWithSize:20];
        _scoreLabel.backgroundColor = [UIColor blueColor];
        
        _restartGameButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth/2, 10 + screenHeight * 5/100 + screenHeight + 2/100 + screenHeight * 10/100, screenWidth * 30/100, screenHeight * 30/100)];
        _restartGameButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"refresh"]];
        [_restartGameButton addTarget:self action:@selector(restartButtonAction) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:_congratulationLabel];
        [self addSubview:_scoreLabel];
        [self addSubview:_restartGameButton];
        
        //self.hidden = YES;
        
        [_congratulationLabel release];
        [_scoreLabel release];
        [_restartGameButton release];
    }
    
    return self;
}

/****** Functions ******/
- (void)displayWithScore:(int)score;{
    _scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.hidden = YES;
}

- (void)restartButtonAction{
    self.hidden = NO;
    [_delegate retain];
    [_delegate restartGame];
    [_delegate release];
}


@end
