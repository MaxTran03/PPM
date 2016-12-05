//
//  MaVue.h
//  NuancierRVB
//
//  Created by m2sar on 24/10/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//


@import UIKit;
@interface MaVue: UIView

@property(nonatomic,retain) UIDevice *terminal;

@property(nonatomic,retain) UILabel *penultieme;
@property(nonatomic,retain) UILabel *precedent;
@property(nonatomic,retain) UILabel *actuel;
@property(nonatomic,retain) UILabel *labelR;
@property(nonatomic,retain) UILabel *labelV;
@property(nonatomic,retain) UILabel *labelB;
@property(nonatomic,retain) UILabel *actuelCouleur;
@property(nonatomic,retain) UILabel *labelSwitch;

@property(nonatomic,retain) UIButton *penultiemeBouton;
@property(nonatomic,retain) UIButton *precedentBouton;
@property(nonatomic,retain) UIButton *remiseAZero;
@property(nonatomic,retain) UIButton *sauvegarder;

@property(nonatomic,retain) UISlider *sliderR;
@property(nonatomic,retain) UISlider *sliderV;
@property(nonatomic,retain) UISlider *sliderB;

@property(nonatomic,retain) UISwitch *switchMode;

@end
