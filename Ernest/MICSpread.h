//
//  MICSpread.h
//  Ernest
//
//  Created by Chris Mitchell on 6/11/14.
//  Copyright (c) 2014 MICharisma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MICSpread : NSObject

@property (nonatomic, retain) NSArray *cards;

+(MICSpread *)initializeWithStack:(NSArray *)card_stack;

-(NSString *)asciiSpread;

@end