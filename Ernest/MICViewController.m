//
//  MICViewController.m
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICViewController.h"
#import "MICCard.h"
#import "MICSpread.h"

@interface MICViewController ()

@end

@implementation MICViewController
- (IBAction)displayBirthCard:(UIDatePicker*)birthdate {
    NSTimeInterval seconds = [birthdate.date timeIntervalSinceNow];
    int years_to_count = seconds / (-60*60*24*365.25);
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:birthdate.date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    
    MICSpread *spread = [MICSpread grand_solar_spread_for_years:years_to_count + 1];
    
    MICCard *birth_card = [MICCard birthCardForMonth:month andDay:day];
    MICCard *karma_card = [birth_card karmaCardOwe];
    MICCard *other_karma_card = [birth_card karmaCardOwed];
    MICCard *environment_card = [spread environmentCardForCard:birth_card];
    
    [spread colorCard:birth_card withColor:[UIColor greenColor]];
    [spread colorCard:karma_card withColor:[UIColor brownColor]];
    [spread colorCard:other_karma_card withColor:[UIColor purpleColor]];
    [spread colorCard:environment_card withColor:[UIColor yellowColor]];
    
    self.suitDisplay.text = birth_card.suit;
    self.faceDisplay.text = birth_card.face;
    [self.solarSpreadDisplay setAttributedText:[spread coloredSpread]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayBirthCard:self.birthDatePicker];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
