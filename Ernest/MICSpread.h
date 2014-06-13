//
//  MICSpread.h
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MICCard;
@class MICPosition;

@interface MICSpread : NSObject

@property (nonatomic, retain) NSArray *cards;

+(MICSpread *)initWithStack:(NSArray *)card_stack;
+(NSMutableArray *)default_card_stack;
+(MICSpread *)natural_spread;
+(MICSpread *)life_spread;
+(MICSpread *)grand_solar_spread_for_years:(NSInteger)years;
-(NSString *)asciiSpread;
-(NSAttributedString *)coloredAsciiSpreadFor:(MICCard *)birth_card;
-(NSInteger)rowOfCard:(MICCard *)card;
-(NSInteger)columnOfCard:(MICCard *)card;
-(MICPosition *)positionOfCard:(MICCard *)card;
-(MICCard *)cardInPosition:(MICPosition *)position;

@end
