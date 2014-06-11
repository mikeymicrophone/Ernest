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
    NSLog([NSString stringWithFormat:@"years_to_count: %d", years_to_count]);
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:birthdate.date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSDateComponents *now = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    
    MICCard *birth_card = [MICCard birthCardForMonth:month andDay:day];
    
    NSMutableArray *solar_spread = [MICCard grand_solar_spread_for_years:years_to_count];
    
    MICSpread *spread = [MICSpread initializeWithStack:solar_spread];
    
    
//    NSLog([NSString stringWithFormat:@"Solar Spread for %d: %@", year, solar_spread]);
    
    int position = 0;
    for (int pos = 0; pos < 55; pos++) {
        position = pos;
        if ([MICCard card:birth_card matchesCard:[solar_spread objectAtIndex:pos]]) {
            break;
        }
    }
//    NSLog([NSString stringWithFormat:@"position of birth card in solar spread: %d", position]);
    
    self.suitDisplay.text = birth_card.suit;
    self.faceDisplay.text = birth_card.face;
    [self.solarSpreadDisplay setAttributedText:[spread coloredAsciiSpreadFor:birth_card]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
