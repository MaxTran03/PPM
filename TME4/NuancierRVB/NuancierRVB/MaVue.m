//
//  MaVue.m
//  NuancierRVB
//
//  Created by m2sar on 24/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MaVue.h"



@interface UIView ()

@end

@implementation MaVue: UIView

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //terminal = [UIDevice currentDevice];

        _penultieme = [[UILabel alloc] init];
        [_penultieme setText: [NSString stringWithFormat:@"Pénultième"]];
        [_penultieme setTextAlignment:NSTextAlignmentCenter];
        
        _precedent = [[UILabel alloc] init];
        [_precedent setText: [NSString stringWithFormat:@"Précédent"]];
        [_precedent setTextAlignment:NSTextAlignmentCenter];
        
        _actuel = [[UILabel alloc] init];
        [_actuel setText: [NSString stringWithFormat:@"Actuel"]];
        [_actuel setTextAlignment:NSTextAlignmentCenter];
        [_actuel setFont:[UIFont boldSystemFontOfSize:16]];
        
        _labelR = [[UILabel alloc] init];
        [_labelR setText: [NSString stringWithFormat:@"R: "]];
        
        _labelV = [[UILabel alloc] init];
        [_labelV setText: [NSString stringWithFormat:@"V: "]];
        
        _labelB = [[UILabel alloc] init];
        [_labelB setText: [NSString stringWithFormat:@"B: "]];
        
        _actuelCouleur = [[UILabel alloc] init];
        
        _penultiemeBouton = [[UIButton alloc] init];
        _precedentBouton = [[UIButton alloc] init];
        
        _sauvegarder = [[UIButton alloc] init];
        [_sauvegarder setTitle:@"Mémoriser" forState:UIControlStateNormal];
        [_sauvegarder setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1] forState:UIControlStateNormal];
        
        _remiseAZero = [[UIButton alloc] init];
        [_remiseAZero setTitle:@"RaZ" forState:UIControlStateNormal];
        [_remiseAZero setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1] forState:UIControlStateNormal];
        
        _sliderR = [[UISlider alloc] init];
        _sliderV = [[UISlider alloc] init];
        _sliderB = [[UISlider alloc] init];
        
        _labelSwitch = [[UILabel alloc] init];
        [_labelSwitch setText:[NSString stringWithFormat:@"Web"]];
        _switchMode = [[UISwitch alloc] init];
        
        [self addSubview: _penultieme];
        [self addSubview: _precedent];
        [self addSubview: _actuel];
        [self addSubview: _labelR];
        [self addSubview: _labelV];
        [self addSubview: _labelB];
        [self addSubview: _actuelCouleur];
        [self addSubview: _penultiemeBouton];
        [self addSubview: _precedentBouton];
        [self addSubview: _remiseAZero];
        [self addSubview: _sauvegarder];
        [self addSubview: _sliderR];
        [self addSubview: _sliderV];
        [self addSubview: _sliderB];
        [self addSubview:_labelSwitch];
        [self addSubview:_switchMode];
        
        [_penultieme release];
        [_precedent release];
        [_actuel release];
        [_labelR release];
        [_labelV release];
        [_labelB release];
        [_actuelCouleur release];
        [_penultiemeBouton release];
        [_precedentBouton release];
        [_sauvegarder release];
        [_remiseAZero release];
        [_sliderR release];
        [_sliderV release];
        [_sliderB release];
        [_labelSwitch release];
        [_switchMode release];
    }
    
    return self;
}


- (void) drawRect:(CGRect)rect {
    if(UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)){
        // Penultieme : Label + Button
        [_penultieme setFrame:CGRectMake(rect.size.width * 50/100 - rect.size.width * 30/100/2,
                                         rect.size.height * 5/100,
                                         rect.size.width * 30/100,
                                         rect.size.height * 4/100)];
    
        [_penultiemeBouton setFrame:CGRectMake(rect.size.width * 5/100,
                                               rect.size.height * 10/100,
                                               rect.size.width * 90/100,
                                               rect.size.height * 6/100)];
    
        // Precedent : Label + Button
        [_precedent setFrame:CGRectMake(rect.size.width * 50/100 - rect.size.width * 30/100/2,
                                        rect.size.height * 19/100,
                                        rect.size.width * 30/100,
                                        rect.size.height * 4/100)];
    
        [_precedentBouton setFrame:CGRectMake(rect.size.width * 5/100,
                                              rect.size.height * 24/100,
                                              rect.size.width * 90/100,
                                              rect.size.height * 6/100)];
    
        // Actuel : Label + Label
        [_actuel setFrame:CGRectMake(rect.size.width * 50/100 - rect.size.width * 30/100/2,
                                     rect.size.height * 33/100,
                                     rect.size.width * 30/100,
                                     rect.size.height * 4/100)];
    
        [_actuelCouleur setFrame:CGRectMake(rect.size.width * 5/100,
                                            rect.size.height * 38/100,
                                            rect.size.width * 90/100,
                                            rect.size.height * 6/100)];
    
        // Slider R : Label + Slider
        [_labelR setFrame:CGRectMake(rect.size.width * 5/100,
                                     rect.size.height * 45/100,
                                     rect.size.width * 20/100,
                                     rect.size.height * 4/100)];
    
        [_sliderR setFrame:CGRectMake(rect.size.width * 5/100,
                                      rect.size.height * 50/100,
                                      rect.size.width * 90/100,
                                      rect.size.height * 5/100)];
    
        // Slider V : Label + Slider
        [_labelV setFrame:CGRectMake(rect.size.width * 5/100,
                                     rect.size.height * 57/100,
                                     rect.size.width * 20/100,
                                     rect.size.height * 4/100)];
    
        [_sliderV setFrame:CGRectMake(rect.size.width * 5/100,
                                      rect.size.height * 62/100,
                                      rect.size.width * 90/100,
                                      rect.size.height * 5/100)];
    
        // Slider B : Label + Slider
        [_labelB setFrame:CGRectMake(rect.size.width * 5/100,
                                     rect.size.height * 69/100,
                                     rect.size.width * 20/100,
                                     rect.size.height * 4/100)];
    
        [_sliderB setFrame:CGRectMake(rect.size.width * 5/100,
                                      rect.size.height * 74/100,
                                      rect.size.width * 90/100,
                                      rect.size.height * 5/100)];

        // Memoriser
        [_sauvegarder setFrame:CGRectMake(rect.size.width * 50/100 - rect.size.width * 30/100/2,
                                          rect.size.height * 80/100,
                                          rect.size.width * 30/100,
                                          rect.size.height * 4/100)];
    
        // Remise à zero
        [_remiseAZero setFrame:CGRectMake(rect.size.width * 50/100 - rect.size.width * 30/100/2,
                                          rect.size.height * 85/100,
                                          rect.size.width * 30/100,
                                          rect.size.height * 4/100)];
    
        // Switch: Label + Switch
        [_labelSwitch setFrame:CGRectMake(rect.size.width * 20/100,
                                          rect.size.height * 90/100,
                                          rect.size.width * 10/100,
                                          rect.size.height * 4/100)];
    
        [_switchMode setFrame:CGRectMake(rect.size.width * 5/100,
                                         rect.size.height * 90/100,
                                         rect.size.width * 15/100,
                                         rect.size.height * 15/100)];
    
    // LANDSCAPE ORIENTATION
    }else if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        [_penultieme setFrame:CGRectMake(rect.size.width * 50/100/2 - rect.size.width * 30/100/2,
                                         rect.size.height * 5/100,
                                         rect.size.width * 30/100,
                                         rect.size.height * 4/100)];
        
        [_penultiemeBouton setFrame:CGRectMake(rect.size.width * 3/100,
                                               rect.size.height * 12/100,
                                               rect.size.width * 44/100,
                                               rect.size.height * 10/100)];
        
        [_precedent setFrame:CGRectMake(rect.size.width * 50/100/2 - rect.size.width * 30/100/2,
                                        rect.size.height * 25/100,
                                        rect.size.width * 30/100,
                                        rect.size.height * 4/100)];
        
        [_precedentBouton setFrame:CGRectMake(rect.size.width * 3/100,
                                              rect.size.height * 32/100,
                                              rect.size.width * 44/100,
                                              rect.size.height * 10/100)];
        
        [_actuel setFrame:CGRectMake(rect.size.width * 50/100/2 - rect.size.width * 30/100/2,
                                     rect.size.height * 45/100,
                                     rect.size.width * 30/100,
                                     rect.size.height * 4/100)];
        
        [_actuelCouleur setFrame:CGRectMake(rect.size.width * 3/100,
                                            rect.size.height * 52/100,
                                            rect.size.width * 44/100,
                                            rect.size.height * 10/100)];
        
        [_sauvegarder setFrame:CGRectMake(rect.size.width * 50/100/2 - rect.size.width * 30/100/2,
                                          rect.size.height * 70/100,
                                          rect.size.width * 30/100,
                                          rect.size.height * 4/100)];
        
        [_labelSwitch setFrame:CGRectMake(rect.size.width * 12/100,
                                          rect.size.height * 90/100 - _switchMode.bounds.size.height/2,
                                          rect.size.width * 10/100,
                                          rect.size.height * 4/100)];
        
        [_switchMode setFrame:CGRectMake(rect.size.width * 3/100,
                                         rect.size.height * 85/100,
                                         rect.size.width * 15/100,
                                         rect.size.height * 15/100)];
        
        [_labelR setFrame:CGRectMake(rect.size.width * 87/100,
                                     rect.size.height * 5/100,
                                     rect.size.width * 10/100,
                                     rect.size.height * 4/100)];
        
        [_sliderR setFrame:CGRectMake(rect.size.width * 53/100,
                                      rect.size.height * 12/100 + _penultiemeBouton.bounds.size.height/3,
                                      rect.size.width * 44/100,
                                      rect.size.height * 5/100)];
        
        [_labelV setFrame:CGRectMake(rect.size.width * 87/100,
                                     rect.size.height * 25/100,
                                     rect.size.width * 10/100,
                                     rect.size.height * 4/100)];
        
        [_sliderV setFrame:CGRectMake(rect.size.width * 53/100,
                                      rect.size.height * 32/100 + _precedentBouton.bounds.size.height/3,
                                      rect.size.width * 44/100,
                                      rect.size.height * 5/100)];
        
        [_labelB setFrame:CGRectMake(rect.size.width * 87/100,
                                     rect.size.height * 45/100,
                                     rect.size.width * 10/100,
                                     rect.size.height * 4/100)];
        
        [_sliderB setFrame:CGRectMake(rect.size.width * 53/100,
                                      rect.size.height * 52/100 + _actuelCouleur.bounds.size.height/3,
                                      rect.size.width * 44/100,
                                      rect.size.height * 5/100)];
        
        [_remiseAZero setFrame:CGRectMake(rect.size.width * 75/100 - rect.size.width * 30/100/2,
                                          rect.size.height * 70/100,
                                          rect.size.width * 30/100,
                                          rect.size.height * 4/100)];
    }
}


@end

