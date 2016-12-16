//
//  GameView.h
//  RouleTaBille
//
//  Created by Max Corp on 12/11/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GameView : UIView<AVAudioPlayerDelegate>

@property(nonatomic, retain) UIImageView * seaStarImageView;
@property(nonatomic, retain) UIImageView * marbleImageView;

@property(nonatomic, retain) AVAudioPlayer * musicBackground;
@property(nonatomic, retain) AVAudioPlayer * squeezeToy;
@property(nonatomic, retain) AVAudioPlayer * musicStar;
@property(nonatomic, retain) AVAudioPlayer * musicWall;

@property(nonatomic, retain) UIDynamicAnimator * animator;
@property(nonatomic, retain) UIDynamicItemBehavior * dynamicItem;
@property(nonatomic, retain) UICollisionBehavior * collision;
@property(nonatomic, retain) UIGravityBehavior * gravity;

@end
