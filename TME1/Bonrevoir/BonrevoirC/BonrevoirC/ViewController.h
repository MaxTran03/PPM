//
//  ViewController.h
//  BonrevoirC
//
//  Created by m2sar on 19/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *LabAffichage;

- (IBAction)actionBouton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *BoutonAction;

@end

