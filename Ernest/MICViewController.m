//
//  MICViewController.m
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICViewController.h"
#import "MICCard.h"

@interface MICViewController ()

@end

@implementation MICViewController
- (IBAction)displayBirthCard:(UIDatePicker*)birthdate {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:birthdate.date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    MICCard *birth_card = [MICCard birthCardForMonth:month andDay:day];
    
    NSMutableArray *solar_spread = [MICCard grand_solar_spread_for_years:2014 - year];
    
    NSLog([NSString stringWithFormat:@"Solar Spread for %d: %@", year, solar_spread]);
    
    int position = 0;
    for (int pos = 0; [MICCard card:birth_card matchesCard:[solar_spread objectAtIndex:pos]]; pos++) {
        position = pos;
    }
    NSLog([NSString stringWithFormat:@"position of birth card in solar spread: %d", position]);
    
    self.suitDisplay.text = birth_card.suit;
    self.faceDisplay.text = birth_card.face;
    self.venusFace.text = [[solar_spread objectAtIndex:position + 1] face];
    self.venusSuit.text = [[solar_spread objectAtIndex:position + 1] suit];
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
