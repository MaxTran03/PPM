//
//  EndGameView.h
//  RouleTaBille
//
//  Created by Max Corp on 12/11/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EndGameViewDelegate <NSObject>

- (void)restartGame;

@end

@interface EndGameView : UIView

@property(nonatomic, assign) id<EndGameViewDelegate> delegate;

@property(nonatomic, retain) UILabel * congratulationLabel;
@property(nonatomic, retain) UILabel * scoreLabel;
@property(nonatomic, retain) UIButton * restartGameButton;

- (void)displayWithScore:(int)score;
- (void)restartButtonAction;

@end
