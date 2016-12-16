//
//  ScoreGameView.h
//  RouleTaBille
//
//  Created by Max Corp on 12/11/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScoreGameView : UIView

@property(nonatomic, retain) UILabel * scoreLabel;
@property(nonatomic, retain) UIImageView * scoreImageView;
@property(nonatomic, assign) int myScore;

- (void)updateScore;
- (void)incrementScore;

@end
