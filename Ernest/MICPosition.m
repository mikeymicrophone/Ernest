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

-(NSInteger)asciiPosition {
    NSInteger starting_position;
    if (self.vertical_position == 7) {
        starting_position = (6 - (self.horizontal_position * 3));
    } else {
        starting_position = (self.vertical_position * 21) + (18 - (self.horizontal_position * 3)) + 9;
    }
    return starting_position;
}

+(NSDictionary *)planetPositions {
    return @{@"0": @"Mercury", @"1": @"Venus", @"2": @"Mars", @"3": @"Jupiter", @"4": @"Saturn", @"5": @"Uranus", @"6": @"Neptune"};
}

+(NSString *)planetForPosition:(NSInteger)position {
    return [[self planetPositions] objectForKey:[NSString stringWithFormat:@"%d", position]];
}

-(MICPosition *)positionWithDisplacement:(NSInteger)places {
//    NSLog([NSString stringWithFormat:@"%d places beyond %@", places, self]);
    MICPosition *finalPosition;
    if (self.vertical_position == 7) {
        if ((self.horizontal_position + places) < 3) {
            finalPosition = [MICPosition initWithHorizontal:self.horizontal_position + places andVertical:self.vertical_position];
        } else {
            NSInteger horizontal = ((self.horizontal_position + places - 3) % 7);
            NSInteger vertical = ((self.horizontal_position + places - 3) / 7);
            finalPosition = [MICPosition initWithHorizontal:horizontal andVertical:vertical];
        }
    } else if (self.vertical_position == 6) {
        if ((self.horizontal_position + places) < 7) {
            finalPosition = [MICPosition initWithHorizontal:self.horizontal_position + places andVertical:self.vertical_position];
        } else if ((self.horizontal_position + places) < 10) {
            finalPosition = [MICPosition initWithHorizontal:(self.horizontal_position + places - 7) andVertical:6];
        } else {
            NSInteger horizontal = (self.horizontal_position + places) - 10;
            NSInteger vertical = horizontal / 7;
            finalPosition = [MICPosition initWithHorizontal:horizontal andVertical:vertical];
        }
    } else {
        if ((self.horizontal_position + places) < 7) {
            finalPosition = [MICPosition initWithHorizontal:(self.horizontal_position + places) andVertical:self.vertical_position];
        } else if ((self.horizontal_position + places) < 14) {
            finalPosition = [MICPosition initWithHorizontal:((self.horizontal_position + places) % 7) andVertical:self.vertical_position + 1];
        }
    }
    
    return finalPosition;
}

-(NSString *)description {
    NSString *description;
    if (self.card) {
        description = [NSString stringWithFormat:@"%@ at %dx%d", self.card, self.horizontal_position, self.vertical_position];
    } else {
        description = [NSString stringWithFormat:@"position at %dx%d", self.horizontal_position, self.vertical_position];
    }
    return description;
}

@end
