//
//  MICPosition.h
//  Ernest
//
//  Created by Chris Mitchell on 6/12/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MICCard;
@class MICSpread;

@interface MICPosition : NSObject

@property (nonatomic, assign) NSInteger vertical_position;
@property (nonatomic, assign) NSInteger horizontal_position;
@property (nonatomic, retain) MICCard *card;
@property (nonatomic, retain) MICSpread *spread;

+(MICPosition *)initWithCard:(MICCard *)card andSpread:(id)spread;
+(MICPosition *)initWithHorizontal:(NSInteger)horizontal andVertical:(NSInteger)vertical;
-(NSString *)horizontalPlanet;
-(NSString *)verticalPlanet;
+(NSDictionary *)planetPositions;
+(NSString *)planetForPosition:(NSInteger)position;

@end
