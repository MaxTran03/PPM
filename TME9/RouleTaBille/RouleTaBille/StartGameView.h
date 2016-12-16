//
//  StartGameAlertView.h
//  RouleTaBille
//
//  Created by Max Corp on 12/10/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartGameViewDelegate <NSObject>

- (void) shouldStartGame;

@end

@interface StartGameView : UIView

@property(nonatomic, assign) id<StartGameViewDelegate> delegate;

@property(nonatomic, retain) NSTimer * countdownTimer;
@property(nonatomic, retain) UILabel * instructionLabel;
@property(nonatomic, retain) UILabel * countdownLabel;
@property(nonatomic, assign) int counter;

- (void)countdownTimerHandler;
- (void)updateCountdownLabel;
- (void)showView;
- (void)hideView;

@end

