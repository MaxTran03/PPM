//
//  ViewController.h
//  RouleTaBille
//
//  Created by Max Corp on 12/4/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartGameView.h"
#import "EndGameView.h"

@interface ViewController : UIViewController<StartGameViewDelegate, EndGameViewDelegate>

@property(nonatomic, retain) NSArray * backgroundImageArray;
@property(nonatomic, assign) int indexImageArray;

@property(nonatomic, retain) StartGameView * startGameV;
@property(nonatomic, retain) EndGameView * endGameV;

- (void)nextBackgroundImageOnShake;

- (void)startGame;

@end

