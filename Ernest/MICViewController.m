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
#import "MICPosition.h"
#import "MICCardPositionViewController.h"

@interface MICViewController ()

@end

@implementation MICViewController
- (IBAction)displayBirthCard:(UIDatePicker*)birthdate {
    NSTimeInterval seconds = [birthdate.date timeIntervalSinceNow];
    NSInteger age = seconds / (-60*60*24*365.25) + 1;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:birthdate.date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    
    self.spread = [MICSpread grand_solar_spread_for_years:age];
    
    self.birth_card = [MICCard birthCardForMonth:month andDay:day];
    self.position_of_birth_card = [self.spread positionOfCard:self.birth_card];
    MICCard *karma_card = [self.birth_card karmaCardOwe];
    MICCard *other_karma_card = [self.birth_card karmaCardOwed];
    MICCard *environment_card = [self.spread environmentCardForCard:self.birth_card];
    MICCard *long_range_card = [self.birth_card longRangeCardForAge:age];
    MICCard *pluto_card = [self.birth_card plutoCardForAge:age];
    MICCard *result_card = [self.birth_card resultCardForAge:age];
    
    [self.spread colorCard:self.birth_card withColor:[UIColor greenColor]];
    [self.spread colorCard:karma_card withColor:[UIColor brownColor]];
    [self.spread colorCard:other_karma_card withColor:[UIColor purpleColor]];
    [self.spread colorCard:environment_card withColor:[UIColor yellowColor]];
    [self.spread colorCard:long_range_card withColor:[UIColor orangeColor]];
    [self.spread colorCard:pluto_card withColor:[UIColor redColor]];
    [self.spread colorCard:result_card withColor:[UIColor blueColor]];
    
    self.suitDisplay.text = self.birth_card.suit;
    self.faceDisplay.text = self.birth_card.face;
    [self.solarSpreadDisplay setAttributedText:[self.spread coloredSpread]];
}

- (IBAction)enterDetailView:(id)sender {
    MICCardPositionViewController *detailController = [[MICCardPositionViewController alloc] initWithPosition:self.position_of_birth_card inSpread:self.spread];
    [self presentViewController:detailController animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayBirthCard:self.birthDatePicker];
//    [MICSpread printDefaultCardStack];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
