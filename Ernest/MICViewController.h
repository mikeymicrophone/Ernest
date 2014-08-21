//
//  MICViewController.h
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MICCard;
@class MICSpread;
@class MICPosition;

@interface MICViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *birthDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *faceDisplay;
@property (weak, nonatomic) IBOutlet UILabel *suitDisplay;
@property (weak, nonatomic) IBOutlet UILabel *solarSpreadDisplay;
@property (weak, nonatomic) MICSpread *spread;
@property (weak, nonatomic) MICCard *birth_card;
@property (weak, nonatomic) MICPosition *position_of_birth_card;

-(IBAction)displayBirthCard:(UIDatePicker *)birthdate;
-(IBAction)enterDetailView:(id)sender;

@end
