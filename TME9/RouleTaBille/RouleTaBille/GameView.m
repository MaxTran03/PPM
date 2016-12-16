//
//  GameView.m
//  RouleTaBille
//
//  Created by Max Corp on 12/11/16.
//  Copyright © 2016 Max Corp. All rights reserved.
//

#import "GameView.h"

@implementation GameView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    //
    if(self){
        _seaStarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"etoile-96"]];
        _marbleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bille"]];
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        _gravity = [[UIGravityBehavior alloc] initWithItems:@[_seaStarImageView, _marbleImageView]];
        [_animator addBehavior:_gravity];
        
        _collision = [[UICollisionBehavior alloc] initWithItems:@[_seaStarImageView, _marbleImageView]];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        [_animator addBehavior:_collision];
        
        _dynamicItem = [[UIDynamicItemBehavior alloc] initWithItems:@[_seaStarImageView, _marbleImageView]];
        [_animator addBehavior:_dynamicItem];
    }
    
    return self;
}

@end
