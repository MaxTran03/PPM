//
//  ScoreGameView.m
//  RouleTaBille
//
//  Created by Max Corp on 12/11/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import "ScoreGameView.h"

@implementation ScoreGameView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        _myScore = 0;
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 75/100, 0, frame.size.width * 20/100, frame.size.height * 20/100)];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.textColor = [UIColor whiteColor];
        
        _scoreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * 50/100, 0, frame.size.width * 25/100, frame.size.height * 20/100)];
        
        
        [self addSubview:_scoreLabel];
        [self addSubview:_scoreImageView];
        
        [_scoreLabel release];
        [_scoreImageView release];
    }
    
    return self;
}

- (void)updateScore{
    _scoreLabel.text = [NSString stringWithFormat:@"%d", _myScore];
}

- (void)incrementScore{
    _myScore += 1;
    [self updateScore];
}

@end
