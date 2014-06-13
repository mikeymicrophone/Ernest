//
//  MICPosition.m
//  Ernest
//
//  Created by Chris Mitchell on 6/12/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICPosition.h"
#import "MICSpread.h"
#import "MICCard.h"

@implementation MICPosition

+(MICPosition *)initWithCard:(MICCard *)card andSpread:(MICSpread *)spread {
    MICPosition *position = [[MICPosition alloc] init];
    position.card = card;
    position.spread = spread;
    position.horizontal_position = [spread columnOfCard:card];
    position.vertical_position = [spread rowOfCard:card];
    return position;
}

+(MICPosition *)initWithHorizontal:(NSInteger)horizontal andVertical:(NSInteger)vertical {
    MICPosition *position = [[MICPosition alloc] init];
    position.horizontal_position = horizontal;
    position.vertical_position = vertical;
    return position;
}

-(NSString *)horizontalPlanet {
    return [MICPosition planetForPosition:self.horizontal_position];
}

-(NSString *)verticalPlanet {
    return [MICPosition planetForPosition:self.vertical_position];
}

+(NSDictionary *)planetPositions {
    return @{@"0": @"Mercury", @"1": @"Venus", @"2": @"Mars", @"3": @"Jupiter", @"4": @"Saturn", @"5": @"Uranus", @"6": @"Neptune"};
}

+(NSString *)planetForPosition:(NSInteger)position {
    return [[self planetPositions] objectForKey:[NSString stringWithFormat:@"%d", position]];
}

@end
