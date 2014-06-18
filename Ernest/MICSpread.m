//
//  MICSpread.m
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import "MICSpread.h"
#import "MICCard.h"
#import "MICPosition.h"

@implementation MICSpread

@synthesize cards;

+(MICSpread *)initWithStack:(NSArray *)card_stack {
    MICSpread *spread = [[self alloc] init];
    spread.cards = card_stack;
    return spread;
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

+(MICSpread *)natural_spread {
    MICSpread *spread = [self initWithStack:[self default_card_stack]];
    return spread;
}

+(MICSpread *)life_spread {
    MICSpread *spread = [self grand_solar_spread_for_years:1];
    return spread;
}

+(MICSpread *)grand_solar_spread_for_years:(NSInteger)years {
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
    MICSpread *spread = [self initWithStack:[[stack reverseObjectEnumerator] allObjects]];
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
    ascii = [NSString stringWithFormat:@"%@|%@|%@\n", [[ruling_group objectAtIndex:2] abbreviation], [[ruling_group objectAtIndex:1] abbreviation], [[ruling_group objectAtIndex:0] abbreviation]];
    
    for (int row = 0; row < 7; row++) {
        NSArray *planetary_group = self.rows[row];
        ascii = [ascii stringByAppendingString:[NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@\n", [[planetary_group objectAtIndex:6] abbreviation], [[planetary_group objectAtIndex:5] abbreviation], [[planetary_group objectAtIndex:4] abbreviation],[[planetary_group objectAtIndex:3] abbreviation],[[planetary_group objectAtIndex:2] abbreviation],[[planetary_group objectAtIndex:1] abbreviation],[[planetary_group objectAtIndex:0] abbreviation]]];
    }
    
//    NSLog([NSString stringWithFormat:@"%@", ascii]);
    
    return ascii;
}

-(NSMutableAttributedString *)coloredAscii {
    NSMutableAttributedString *ascii = [[NSMutableAttributedString alloc] initWithString:[self asciiSpread]];
    return ascii;
}

-(NSAttributedString *)coloredAsciiSpreadFor:(MICCard *)birth_card {
    __block int birth_card_row;
    __block int birth_card_column;
    [self.rows enumerateObjectsUsingBlock:^(NSArray *planetary_group, NSUInteger row, BOOL *stop) {
        [planetary_group enumerateObjectsUsingBlock:^(MICCard *card, NSUInteger column, BOOL *stop) {
            if ([card matchesCard:birth_card]) {
                birth_card_row = row;
                birth_card_column = column;
                *stop = YES;
            }
        }];
    }];
//    NSLog([NSString stringWithFormat:@"The birth row is %d and the column is %d", birth_card_row, birth_card_column]);
    
    UIColor *birth_card_color = [UIColor greenColor];
    int starting_position = 0;
    if (birth_card_row == 7) {
        starting_position = [[@{@"0":@6,@"1":@3, @"2":@0} objectForKey:[NSString stringWithFormat:@"%d", birth_card_column]] intValue];
    } else {
        starting_position = 9 + (21 * birth_card_row) + [[@{@"0":@18,@"1":@15,@"2":@12,@"3":@9,@"4":@6,@"5":@3,@"6":@0} objectForKey:[NSString stringWithFormat:@"%d", birth_card_column]] intValue];
    }
    self.coloredSpread = [self coloredAscii];
    
    [self.coloredSpread addAttribute:NSForegroundColorAttributeName value:birth_card_color range:NSMakeRange(starting_position, 2)];
    
    UIColor *year_path_color = [UIColor blueColor];
    if (birth_card_row == 7) {
        // no year path
    } else {
        int first_row = birth_card_row;
        int second_row;
        int third_row;
        switch (birth_card_row) {
            case 0:
                second_row = 1;
                third_row = 2;
                break;
            case 1:
                second_row = 2;
                third_row = 3;
                break;
            case 2:
                second_row = 3;
                third_row = 4;
                break;
            case 3:
                second_row = 4;
                third_row = 5;
                break;
            case 4:
                second_row = 5;
                third_row = 6;
                break;
            case 5:
                second_row = 6;
                third_row = 0;
                break;
            case 6:
                second_row = 0;
                third_row = 1;
                break;
            default:
                break;
        }
        
        int first_row_end;
        int second_row_start;
        int third_row_start;
        switch (birth_card_column) {
            case 0:
                first_row_end = 18;
                second_row_start = 3;
                third_row_start = 0;
                break;
            case 1:
                first_row_end = 15;
                second_row_start = 0;
                third_row_start = 0;
                break;
            case 2:
                first_row_end = 12;
                second_row_start = 0;
                third_row_start = 18;
                break;
            case 3:
                first_row_end = 9;
                second_row_start = 0;
                third_row_start = 15;
                break;
            case 4:
                first_row_end = 6;
                second_row_start = 0;
                third_row_start = 12;
                break;
            case 5:
                first_row_end = 3;
                second_row_start = 0;
                third_row_start = 9;
                break;
            case 6:
                first_row_end = 0;
                second_row_start = 0;
                third_row_start = 6;
                break;
                
            default:
                break;
        }
        
        [self.coloredSpread addAttribute:NSForegroundColorAttributeName value:year_path_color range:NSMakeRange(9 + (21 * first_row), first_row_end)];
        [self.coloredSpread addAttribute:NSForegroundColorAttributeName value:year_path_color range:NSMakeRange(9 + (21 * second_row) + second_row_start, (21 - second_row_start))];
        if (third_row_start != 0) {
            [self.coloredSpread addAttribute:NSForegroundColorAttributeName value:year_path_color range:NSMakeRange(9 + (21 * third_row) + third_row_start, (21 - third_row_start))];
        }
    }
    
    return self.coloredSpread;
}

-(void)colorCard:(MICCard *)card withColor:(UIColor *)color {
    if (!self.coloredSpread) {
        self.coloredSpread = [self coloredAscii];
    }
    NSRange colored_range = NSMakeRange([[self positionOfCard:card] asciiPosition], 2);
    [self.coloredSpread addAttribute:NSForegroundColorAttributeName value:color range:colored_range];
}

-(NSInteger)rowOfCard:(MICCard *)card {
    __block int birth_card_row;
    [self.rows enumerateObjectsUsingBlock:^(NSArray *planetary_group, NSUInteger row, BOOL *stop) {
        [planetary_group enumerateObjectsUsingBlock:^(MICCard *placedCard, NSUInteger column, BOOL *stop) {
            if ([card matchesCard:placedCard]) {
                birth_card_row = row;
                *stop = YES;
            }
        }];
    }];
    return birth_card_row;
}

-(NSInteger)columnOfCard:(MICCard *)card {
    __block int birth_card_column;
    [self.rows enumerateObjectsUsingBlock:^(NSArray *planetary_group, NSUInteger row, BOOL *stop) {
        [planetary_group enumerateObjectsUsingBlock:^(MICCard *placedCard, NSUInteger column, BOOL *stop) {
            if ([card matchesCard:placedCard]) {
                birth_card_column = column;
                *stop = YES;
            }
        }];
    }];
    return birth_card_column;
}

-(MICPosition *)positionOfCard:(MICCard *)card {
    MICPosition *position = [MICPosition initWithHorizontal:[self columnOfCard:card] andVertical:[self rowOfCard:card]];
    return position;
}

-(MICCard *)cardInPosition:(MICPosition *)position {
    MICCard *card = [[[self rows] objectAtIndex:position.vertical_position] objectAtIndex:position.horizontal_position];
    return card;
}

-(MICCard *)environmentCardForCard:(MICCard *)birth_card {
    MICCard *card = [self cardInPosition:[[MICSpread life_spread] positionOfCard:birth_card]];
//    NSLog([NSString stringWithFormat:@"environment card: %@", card]);
    return card;
}

+(MICSpread *)spreadForAge:(NSInteger)age {
    NSInteger spreadIndex;
    if (age % 7 == 0) {
        spreadIndex = age / 7;
    } else {
        spreadIndex = (age / 7) + 1;
    }
    MICSpread *spread = [MICSpread grand_solar_spread_for_years:spreadIndex];
    return spread;
}

-(MICPosition *)positionBeyondCard:(MICCard *)card byPlaces:(NSInteger)places {
    MICPosition *startingPosition = [self positionOfCard:card];
    MICPosition *finalPosition = [startingPosition positionWithDisplacement:places];
    return finalPosition;
}

@end
