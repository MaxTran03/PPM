//
//  MaVue.h
//  Imagier
//
//  Created by m2sar on 29/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaVue : UIView <UIScrollViewDelegate>

@property(nonatomic, retain) UISlider *sliderScroll;
@property(nonatomic, retain) UIToolbar *navBar;
@property(nonatomic, retain) UIImageView *imageView;
@property(nonatomic, retain) UIScrollView *scroll;
@property(nonatomic, retain) UIToolbar *toolBar;

@property(nonatomic, retain) UIBarButtonItem *next;
@property(nonatomic, retain) UIBarButtonItem *previous;
@property(nonatomic, retain) UIBarButtonItem *flexible;
@property(nonatomic, retain) UIBarButtonItem *labelItem;

@property(nonatomic, retain) NSMutableArray<NSString *> *imageArray;
@property(nonatomic, retain) NSMutableArray<NSNumber *> *imagePercent;

@property(nonatomic, retain) UILabel *percent;
@property(nonatomic, retain) UILabel *imageName;

@property(nonatomic) int maxArray;
@property(nonatomic) int i;

- (void) drawInFormat: (CGSize) format;

@end
