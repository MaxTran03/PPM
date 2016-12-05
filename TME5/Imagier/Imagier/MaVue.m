//
//  MaVue.m
//  Imagier
//
//  Created by m2sar on 28/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MaVue.h"

@implementation MaVue


- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.maxArray = 20;
    
    if(self){
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
        [statusBar setBackgroundColor:[UIColor whiteColor]];
        
        // Create an array of image
        self.imageArray = [[NSMutableArray<NSString *> alloc] initWithCapacity:self.maxArray];
        
        // Create an array for the percent value of each images
        self.imagePercent = [[NSMutableArray<NSNumber *> alloc] initWithCapacity:self.maxArray];
        
        for(self.i=0; self.i<self.maxArray; self.i++){
            [self.imageArray addObject:[NSString stringWithFormat:@"photo-%d", self.i+1]];
            [self.imagePercent addObject:[NSNumber numberWithFloat:0.2]];
        }
        
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageArray[0]]];
        
        // Create toolbar
        self.toolBar = [[UIToolbar alloc] initWithFrame:frame];
        
        // Create label
        self.percent = [[UILabel alloc] init];
        self.imageName = [[UILabel alloc] init];
        
        // Create items
        self.next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:NULL action:NULL];
        self.previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:NULL action:NULL];
        self.flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:NULL action:NULL];
        self.labelItem = [[UIBarButtonItem alloc] initWithCustomView:self.imageName];
        
        // Add items
        [self.toolBar setItems:[NSArray<UIBarButtonItem *> arrayWithObjects:self.previous, self.flexible, self.labelItem, self.flexible, self.next, nil] animated:true];
        
        // Create scroll
        self.scroll = [[UIScrollView alloc] initWithFrame:frame];
        [self.scroll setBackgroundColor:[UIColor whiteColor]];
        [self.scroll setMaximumZoomScale:1.0];
        [self.scroll setMinimumZoomScale:0.05];
        [self.scroll setDelegate:self];
        [self.scroll setZoomScale:0.2 animated:YES];
    
        // Create slider
        self.sliderScroll = [[UISlider alloc] initWithFrame:frame];
        [self.sliderScroll setMaximumValue: 1.0];
        [self.sliderScroll setMinimumValue: 0.05];
        
        
        // Parallax effect
        UIInterpolatingMotionEffect *vMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        [vMotionEffect setMinimumRelativeValue:@(-[[UIScreen mainScreen] bounds].size.height / 40)];
        [vMotionEffect setMaximumRelativeValue:@([[UIScreen mainScreen] bounds].size.height / 40)];
        
        UIInterpolatingMotionEffect *hMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        [hMotionEffect setMinimumRelativeValue:@(-[[UIScreen mainScreen] bounds].size.height / 40)];
        [hMotionEffect setMaximumRelativeValue:@([[UIScreen mainScreen] bounds].size.height / 40)];
        
        // Add subview
        [self.scroll addSubview:self.imageView];
        [self addSubview:self.scroll];
        [self addSubview:self.sliderScroll];
        [self addSubview:self.toolBar];
        [self addSubview:self.percent];
        [self addMotionEffect:vMotionEffect];
        [self addMotionEffect:hMotionEffect];
        
        // Release
        [self.imageView release];
        [self.scroll release];
        [self.sliderScroll release];
        [self.toolBar release];
        [self.next release];
        [self.previous release];
        [self.flexible release];
        [self.percent release];
        [self.imageName release];
        [self.labelItem release];
        [self.imageArray release];
        [self.imagePercent release];
        [vMotionEffect release];
        [hMotionEffect release];
        
        //[self drawInFormat: frame.size];
    }
    
    return self;
}

- (UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

- (void) scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale];
    // Pour une seule dimension...
    //[view setFrame:CGRectMake([view frame].origin.x, [view frame].origin.y, [view frame].size.width, [view frame].size.height);
}

/*
- (void) drawInFormat: (CGSize) format{
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.sliderScroll.frame = CGRectMake(format.width * 10/100,
                                         format.height * 90/100,
                                         format.width * 80/100,
                                         format.height * 10/100);
    
    self.toolBar.frame = CGRectMake(0,
                                    statusBarHeight,
                                    format.width,
                                    format.height * 5/100);
    
    self.scroll.frame = CGRectMake(0,
                                   self.toolBar.bounds.size.height + statusBarHeight,
                                   format.width,
                                   format.height - self.toolBar.bounds.size.height - statusBarHeight);
    
    self.percent.frame = CGRectMake(5,
                                    self.toolBar.bounds.size.height + statusBarHeight,
                                    50,
                                    20);
    [self.percent setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.3f]];
    [self.percent setTextAlignment:NSTextAlignmentCenter];
    
    self.imageName.frame = CGRectMake(self.toolBar.bounds.origin.x,
                                      statusBarHeight,
                                      format.width * 20/100,
                                      format.height * 4/100);
    [self.imageName setTextAlignment:NSTextAlignmentCenter];
    
    
    self.imageView.frame = CGRectMake(0, 0, [UIImage imageNamed:self.imageArray[self.i]].size.width, [UIImage imageNamed:self.imageArray[self.i]].size.height);

}*/


- (void) drawRect:(CGRect)rect{
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.sliderScroll.frame = CGRectMake(rect.size.width * 10/100,
                                         rect.size.height * 90/100,
                                         rect.size.width * 80/100,
                                         rect.size.height * 10/100);
    
    self.toolBar.frame = CGRectMake(rect.origin.x,
                                    statusBarHeight,
                                    rect.size.width,
                                    rect.size.height * 5/100);
    
    self.scroll.frame = CGRectMake(rect.origin.x,
                                   rect.origin.y + self.toolBar.bounds.size.height + statusBarHeight,
                                   rect.size.width,
                                   rect.size.height - self.toolBar.bounds.size.height - statusBarHeight);
    
    self.percent.frame = CGRectMake(rect.origin.x + 5,
                                    rect.origin.y + self.toolBar.bounds.size.height + statusBarHeight,
                                    50,
                                    20);
    [self.percent setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.3f]];
    [self.percent setTextAlignment:NSTextAlignmentCenter];
    
    self.imageName.frame = CGRectMake(self.toolBar.bounds.origin.x,
                                      statusBarHeight,
                                      rect.size.width * 20/100,
                                      rect.size.height * 4/100);
    [self.imageName setTextAlignment:NSTextAlignmentCenter];
    
        
    self.imageView.frame = CGRectMake(0, 0, [UIImage imageNamed:self.imageArray[self.i]].size.width, [UIImage imageNamed:self.imageArray[self.i]].size.height);

}

@end
