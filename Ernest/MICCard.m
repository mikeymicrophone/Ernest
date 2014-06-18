//
//  MICCard.m
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICCard.h"
#import "MICSpread.h"
#import "MICPosition.h"

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
    MICCard *card = [[MICSpread default_card_stack] objectAtIndex:position];
    return card;
}

+(BOOL)card:(MICCard *)card matchesCard:(MICCard *)match {
    if (card.suit == match.suit) {
        if (card.face == match.face) {
            return YES;
        }
    }
    return NO;
}

-(BOOL)matchesCard:(MICCard *)match {
    if (suit == match.suit) {
        if (face == match.face) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)abbreviation {
    NSDictionary *face_abbreviations = @{@"Ace": @"A", @"Two": @"2", @"Three": @"3", @"Four": @"4", @"Five": @"5", @"Six": @"6", @"Seven": @"7", @"Eight": @"8", @"Nine": @"9", @"Ten": @"T", @"Jack": @"J", @"Queen": @"Q", @"King": @"K"};
    NSString *face_abbreviation = [face_abbreviations objectForKey:self.face];
    NSString *suit_abbreviation = [self.suit substringToIndex:1];
    
    return [face_abbreviation stringByAppendingString:suit_abbreviation];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ of %@", self.face, self.suit];
}

-(MICCard *)karmaCardOwe {
    MICCard *karma_card = [[MICSpread natural_spread] cardInPosition:[[MICSpread life_spread] positionOfCard:self]];
//    NSLog([NSString stringWithFormat:@"karma card: %@", karma_card]);
    return karma_card;
}

-(MICCard *)karmaCardOwed {
    MICCard *karma_card = [[MICSpread life_spread] cardInPosition:[[MICSpread natural_spread] positionOfCard:self]];
//    NSLog([NSString stringWithFormat:@"karma card: %@", karma_card]);
    return karma_card;
}

-(MICCard *)longRangeCardForAge:(NSInteger)age {
    MICSpread *eraSpread = [MICSpread spreadForAge:age];
    NSInteger range;
    if ((age % 7) == 0) {
        range = 7;
    } else {
        range = age % 7;
    }
    MICCard *longRangeCard = [eraSpread cardInPosition:[eraSpread positionBeyondCard:self byPlaces:range]];
    return longRangeCard;
}

-(MICCard *)plutoCardForAge:(NSInteger)age {
    MICSpread *eraSpread = [MICSpread spreadForAge:age];
    MICCard *plutoCard = [eraSpread cardInPosition:[eraSpread positionBeyondCard:self byPlaces:8]];
    return plutoCard;
}

@end
