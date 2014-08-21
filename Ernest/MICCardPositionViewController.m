//
//  MICCardPositionViewController.m
//  Ernest
//
//  Created by Chris Mitchell on 7/1/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICCardPositionViewController.h"
#import "MICPosition.h"
#import "MICSpread.h"
#import "MICCard.h"

@interface MICCardPositionViewController ()

@end

@implementation MICCardPositionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(MICCardPositionViewController *)initWithPosition:(MICPosition *)position inSpread:(MICSpread *)spread{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.spread = spread;
        self.position = position;
        self.card = [spread cardInPosition:position];
    }
    return self;
}

-(void)displayCardInfo {
    self.cardAbbreviation.text = [self.card abbreviation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayCardInfo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
