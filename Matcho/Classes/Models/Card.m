//
//  Card.m
//  Matchismo
//
//  Created by Anton Lookin on 10/19/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards {

    int score = 0;
	
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

-(UIColor *)color{
    return [UIColor grayColor];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Drawed card %@",[self contents]];
}

@end
