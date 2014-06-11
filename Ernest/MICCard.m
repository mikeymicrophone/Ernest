//
//  MICCard.m
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICCard.h"

@implementation MICCard

@synthesize suit;
@synthesize face;

+(MICCard *)initWithSuit:(NSString *)suit andFace:(NSString *)face {
    MICCard *card = [[self alloc] init];
    card.suit = suit;
    card.face = face;
    return card;
}

+(MICCard *)birthCardForMonth:(NSInteger)month andDay:(NSInteger)day {
    int position = 55 - ((month * 2) + day);
    
    MICCard *card = [[MICCard default_card_stack] objectAtIndex:position];
    return card;
}

+(NSMutableArray *)default_card_stack {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    NSArray *suits = @[@"Hearts", @"Clubs", @"Diamonds", @"Spades"];
    NSArray *faces = @[@"Ace", @"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", @"Jack", @"Queen", @"King"];
    for (NSString *suit in suits) {
        for (NSString *face in faces) {
            [cards addObject:[MICCard initWithSuit:suit andFace:face]];
        }
    }
    return cards;
}

@end
