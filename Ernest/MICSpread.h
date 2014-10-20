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
@property (nonatomic, retain) NSMutableAttributedString *coloredSpread;

+(MICSpread *)initWithStack:(NSArray *)card_stack;
+(NSMutableArray *)default_card_stack;
+(void)printDefaultCardStack;
+(MICSpread *)natural_spread;
+(MICSpread *)life_spread;
+(MICSpread *)grand_solar_spread_for_years:(NSInteger)years;
-(NSString *)asciiSpread;
-(NSMutableAttributedString *)coloredAscii;
-(NSAttributedString *)coloredAsciiSpreadFor:(MICCard *)birth_card;
-(void)colorCard:(MICCard *)card withColor:(UIColor *)color;
-(NSInteger)rowOfCard:(MICCard *)card;
-(NSInteger)columnOfCard:(MICCard *)card;
-(MICPosition *)positionOfCard:(MICCard *)card;
-(MICCard *)cardInPosition:(MICPosition *)position;
-(MICCard *)environmentCardForCard:(MICCard *)birth_card;
+(MICSpread *)spreadForAge:(NSInteger)age;
-(MICPosition *)positionBeyondCard:(MICCard *)card byPlaces:(NSInteger)places;

@end
