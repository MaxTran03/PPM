//
//  ViewController.m
//  BonrevoirC
//
//  Created by m2sar on 19/09/2016.
//  Copyright © 2016 UPMC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

BOOL boutonActionnee = TRUE;

- (IBAction)actionBouton:(id)sender {
    /*if(!boutonActionnee){
        // Le bouton est positionné à "Dis Au revoir"
        [sender setTitle:@"Dis Bonjour" forState:UIControlStateNormal];
        [_LabAffichage setText:@"Au revoir le monde"];
        boutonActionnee = TRUE;
    }else{
        // Le bouton est positionné à "Dis Bonjour"
        [sender setTitle:@"Dis Au revoir" forState:UIControlStateNormal];
        [_LabAffichage setText:@"Bonjour le monde"];
        boutonActionnee = FALSE;
    }*/
    
    NSString *buttonTitle = [sender titleForState:UIControlStateNormal];
    
    if( [buttonTitle isEqualToString:@"Dis Bonjour"] ){
        [_LabAffichage setText:@"Bonjour le monde"];
        [sender setTitle:@"Dis Au Revoir" forState:UIControlStateNormal];
    }else{
        [_LabAffichage setText:@"Dis Au revoir"];
        [sender setTitle:@"Dis Bonjour" forState:UIControlStateNormal];
    }
}
@end
