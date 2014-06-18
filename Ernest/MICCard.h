//
//  MICCard.h
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MICSpread;
@class MICPosition;

@interface MICCard : NSObject

@property (nonatomic, retain) NSString *suit;
@property (nonatomic, retain) NSString *face;

+(MICCard *)initWithSuit:(NSString *)suit andFace:(NSString *)face;
+(MICCard *)birthCardForMonth:(NSInteger)month andDay:(NSInteger)day;

+(BOOL)card:(MICCard *)card matchesCard:(MICCard *)match;
-(BOOL)matchesCard:(MICCard *)match;
-(MICCard *)karmaCardOwe;
-(MICCard *)karmaCardOwed;
-(MICCard *)longRangeCardForAge:(NSInteger)age;
-(MICCard *)plutoCardForAge:(NSInteger)age;
-(NSString *)description;
-(NSString *)abbreviation;

@end
