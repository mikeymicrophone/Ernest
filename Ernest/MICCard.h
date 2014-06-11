//
//  MICCard.h
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MICCard : NSObject

@property (nonatomic, retain) NSString *suit;
@property (nonatomic, retain) NSString *face;

+(MICCard *)initWithSuit:(NSString *)suit andFace:(NSString *)face;
+(MICCard *)birthCardForMonth:(NSInteger)month andDay:(NSInteger)day;
+(NSMutableArray *)default_card_stack;
+(NSMutableArray *)grand_solar_spread_for_years:(NSInteger)years;
+(BOOL)card:(MICCard *)card matchesCard:(MICCard *)match;
-(NSString *)description;

@end
