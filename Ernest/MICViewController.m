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
    
    self.suitDisplay.text = birth_card.suit;
    self.faceDisplay.text = birth_card.face;
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
