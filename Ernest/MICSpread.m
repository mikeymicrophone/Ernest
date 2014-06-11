//
//  MICSpread.m
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICSpread.h"

@implementation MICSpread

@synthesize cards;

+(MICSpread *)initializeWithStack:(NSArray *)card_stack {
    MICSpread *spread = [[self alloc] init];
    spread.cards = card_stack;
    return spread;
}

-(NSArray *)rows {
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    
    int spread_position = 0;
    
    for (int row = 0; row < 7; row++) {
        NSArray *planetary_group = [self.cards objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(spread_position, 7)]];
        [rows insertObject:planetary_group atIndex:row];
        spread_position += 7;
    }

    NSArray *ruling_group = [NSArray arrayWithObjects:[self.cards objectAtIndex:49], [self.cards objectAtIndex:50], [self.cards objectAtIndex:51], nil];

    [rows insertObject:ruling_group atIndex:7];
    
    return rows;
}

-(NSString *)asciiSpread {
    NSString *ascii;
    NSArray *ruling_group = [[self rows] objectAtIndex:7];
    ascii = [NSString stringWithFormat:@"      %@|%@|%@      \n", [[ruling_group objectAtIndex:2] abbreviation], [[ruling_group objectAtIndex:1] abbreviation], [[ruling_group objectAtIndex:0] abbreviation]];
    
    for (int row = 0; row < 7; row++) {
        NSArray *planetary_group = self.rows[row];
        ascii = [ascii stringByAppendingString:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@\n", [[planetary_group objectAtIndex:6] abbreviation], [[planetary_group objectAtIndex:5] abbreviation], [[planetary_group objectAtIndex:4] abbreviation],[[planetary_group objectAtIndex:3] abbreviation],[[planetary_group objectAtIndex:2] abbreviation],[[planetary_group objectAtIndex:1] abbreviation],[[planetary_group objectAtIndex:0] abbreviation]]];
    }
    
    NSLog([NSString stringWithFormat:@"%@", ascii]);
    
    return ascii;
}

@end
