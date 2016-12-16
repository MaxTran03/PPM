//
//  StartGameAlertView.m
//  RouleTaBille
//
//  Created by Max Corp on 12/10/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StartGameView.h"

@implementation StartGameView

- (instancetype)init{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGRect frame = CGRectMake(screenWidth * 5/100, screenHeight/2 - screenHeight * 15/100, screenWidth * 90/100, screenHeight * 30/100);
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor = [UIColor grayColor];
        
        _instructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, screenWidth * 90/100, screenHeight * 15/100)];
        _instructionLabel.textAlignment = NSTextAlignmentCenter;
        _instructionLabel.textColor = [UIColor whiteColor];
        _instructionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _instructionLabel.numberOfLines = 3;
        _instructionLabel.text = [NSString stringWithFormat:@"Ramassez un maximum\nd'étoile en 1 minute\nBonne chance !"];
        //_instructionLabel.backgroundColor = [UIColor blackColor];
        
        _counter = 5;
        
        _countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + screenHeight * 15/100 + screenHeight * 2/100, screenWidth * 90/100, screenHeight * 10/100)];
        _countdownLabel.textAlignment = NSTextAlignmentCenter;
        _countdownLabel.textColor = [UIColor whiteColor];
        _countdownLabel.text = [NSString stringWithFormat:@"%d", _counter];
        _countdownLabel.font = [_countdownLabel.font fontWithSize:30];
        //_countdownLabel.backgroundColor = [UIColor blackColor];
        
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownTimerHandler) userInfo:nil repeats:YES];
        
        [self addSubview:_instructionLabel];
        [self addSubview:_countdownLabel];
        
        self.hidden = YES;
        
        [_instructionLabel release];
    }
    
    return self;
}


/****** Functions ******/
- (void)updateCountdownLabel{
    _countdownLabel.text = [NSString stringWithFormat:@"%d", _counter];
}

- (void)countdownTimerHandler{
    _counter -= 1;
    [self updateCountdownLabel];
    
    // When _counter = 0, game will start
    if(_counter == 0){
        [_countdownTimer invalidate];
        _countdownTimer = nil;
        
        // We don't really need this -if statement, but if we do have an optional method in our StartGameViewDelegate protocol: it's needed to check if delegate does or does not implement that method
        [_delegate retain];
        if([_delegate respondsToSelector:@selector(shouldStartGame)]){
            [_delegate shouldStartGame];
        }
        [_delegate release];
    }
}

- (void)showView{
    self.hidden = NO;
}

- (void)hideView{
    self.hidden = YES;
}

@end
