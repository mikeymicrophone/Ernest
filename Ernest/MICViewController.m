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
    NSInteger age = seconds / (-60*60*24*365.25) + 1;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:birthdate.date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    
    MICSpread *spread = [MICSpread grand_solar_spread_for_years:age];
    
    MICCard *birth_card = [MICCard birthCardForMonth:month andDay:day];
    MICCard *karma_card = [birth_card karmaCardOwe];
    MICCard *other_karma_card = [birth_card karmaCardOwed];
    MICCard *environment_card = [spread environmentCardForCard:birth_card];
    MICCard *long_range_card = [birth_card longRangeCardForAge:age];
    MICCard *pluto_card = [birth_card plutoCardForAge:age];
    
    [spread colorCard:birth_card withColor:[UIColor greenColor]];
    [spread colorCard:karma_card withColor:[UIColor brownColor]];
    [spread colorCard:other_karma_card withColor:[UIColor purpleColor]];
    [spread colorCard:environment_card withColor:[UIColor yellowColor]];
    [spread colorCard:long_range_card withColor:[UIColor orangeColor]];
    [spread colorCard:pluto_card withColor:[UIColor redColor]];
    
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
