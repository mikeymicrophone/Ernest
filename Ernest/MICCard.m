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
    int position = 54 - ((month * 2) + day);
    MICCard *card = [[MICCard default_card_stack] objectAtIndex:position];
    return card;
}

+(NSMutableArray *)default_card_stack {
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    NSArray *suits = @[@"Hearts", @"Clubs", @"Diamonds", @"Spades"];
    NSArray *faces = @[@"Ace", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", @"Jack", @"Queen", @"King"];
    for (NSString *suit in suits) {
        for (NSString *face in faces) {
            [cards addObject:[MICCard initWithSuit:suit andFace:face]];
        }
    }
    return cards;
}

+(NSMutableArray *)grand_solar_spread_for_years:(NSInteger)years {
    NSMutableArray *stack = [[[self default_card_stack] reverseObjectEnumerator] allObjects];
    
    for (int i = 0; i < years; i++) {
        NSMutableArray *hearts_pile = [[NSMutableArray alloc] init];
        NSMutableArray *clubs_pile = [[NSMutableArray alloc] init];
        NSMutableArray *diamonds_pile = [[NSMutableArray alloc] init];
        NSMutableArray *spades_pile = [[NSMutableArray alloc] init];
        int last_card = 51;

        for (int j = 0; j < 4; j++) {
            [hearts_pile addObject:[stack objectAtIndex:(last_card - 2)]];
            [hearts_pile addObject:[stack objectAtIndex:(last_card - 1)]];
            [hearts_pile addObject:[stack objectAtIndex:(last_card)]];
            [clubs_pile addObject:[stack objectAtIndex:(last_card - 5)]];
            [clubs_pile addObject:[stack objectAtIndex:(last_card - 4)]];
            [clubs_pile addObject:[stack objectAtIndex:(last_card - 3)]];
            [diamonds_pile addObject:[stack objectAtIndex:(last_card - 8)]];
            [diamonds_pile addObject:[stack objectAtIndex:(last_card - 7)]];
            [diamonds_pile addObject:[stack objectAtIndex:(last_card - 6)]];
            [spades_pile addObject:[stack objectAtIndex:(last_card - 11)]];
            [spades_pile addObject:[stack objectAtIndex:(last_card - 10)]];
            [spades_pile addObject:[stack objectAtIndex:(last_card - 9)]];
            last_card = last_card - 12;
        }
        
        [hearts_pile addObject:[stack objectAtIndex:3]];
        [clubs_pile addObject:[stack objectAtIndex:2]];
        [diamonds_pile addObject:[stack objectAtIndex:1]];
        [spades_pile addObject:[stack objectAtIndex:0]];
        
        [hearts_pile addObjectsFromArray:clubs_pile];
        [hearts_pile addObjectsFromArray:diamonds_pile];
        [hearts_pile addObjectsFromArray:spades_pile];
        
        stack = hearts_pile;
//        NSLog([NSString stringWithFormat:@"current ordering midway after %d stretches: %@", i, stack]);
        
        hearts_pile = [[NSMutableArray alloc] init];
        clubs_pile = [[NSMutableArray alloc] init];
        diamonds_pile = [[NSMutableArray alloc] init];
        spades_pile = [[NSMutableArray alloc] init];
        
        last_card = 51;
        
        for (int k = 0; k < 13; k++) {
            [hearts_pile addObject:[stack objectAtIndex:(last_card)]];
            [clubs_pile addObject:[stack objectAtIndex:(last_card - 1)]];
            [diamonds_pile addObject:[stack objectAtIndex:(last_card - 2)]];
            [spades_pile addObject:[stack objectAtIndex:(last_card - 3)]];
            
            last_card = last_card - 4;
        }
        
        [hearts_pile addObjectsFromArray:clubs_pile];
        [hearts_pile addObjectsFromArray:diamonds_pile];
        [hearts_pile addObjectsFromArray:spades_pile];
        
        stack = hearts_pile;
//        NSLog([NSString stringWithFormat:@"current ordering after %d stretches: %@", i, stack]);
    }
    return [[stack reverseObjectEnumerator] allObjects];
}

+(BOOL)card:(MICCard *)card matchesCard:(MICCard *)match {
    if (card.suit == match.suit) {
        if (card.face == match.face) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)abbreviation {
    NSDictionary *face_abbreviations = @{@"Ace": @"A", @"Two": @"2", @"Three": @"3", @"Four": @"4", @"Five": @"5", @"Six": @"6", @"Seven": @"7", @"Eight": @"8", @"Nine": @"9", @"Ten": @"10", @"Jack": @"J", @"Queen": @"Q", @"King": @"K"};
    NSString *face_abbreviation = [face_abbreviations objectForKey:self.face];
    NSString *suit_abbreviation = [self.suit substringToIndex:1];
    
    return [face_abbreviation stringByAppendingString:suit_abbreviation];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ of %@", self.face, self.suit];
}

@end
