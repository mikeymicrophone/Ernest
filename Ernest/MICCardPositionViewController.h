//
//  MICCardPositionViewController.h
//  Ernest
//
//  Created by Chris Mitchell on 7/1/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MICPosition;
@class MICSpread;
@class MICCard;

@interface MICCardPositionViewController : UIViewController

@property (nonatomic, retain) MICSpread *spread;
@property (nonatomic, retain) MICPosition *position;
@property (nonatomic, retain) MICCard *card;
@property (weak, nonatomic) UILabel *cardAbbreviation;


-(MICCardPositionViewController *)initWithPosition:(MICPosition *)position inSpread:(MICSpread *)spread;

@end
