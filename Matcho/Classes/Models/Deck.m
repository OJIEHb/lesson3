//
//  Deck.m
//  Matchismo
//
//  Created by Anton Lookin on 10/19/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (nonatomic, strong) NSMutableArray *cards;

@property (nonatomic) NSInteger countCardsFlipp;

@end


@implementation Deck

- (NSMutableArray *)cards {
	if (!_cards) {
		_cards = [[NSMutableArray alloc] init];
        _countCardsFlipp = 0;
	}
	return _cards;
}


- (void)addCard:(Card *)card {
	[self addCard:card atTop:NO];
}

- (NSInteger)getCountFlippedCards{
    return _countCardsFlipp;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
	if (atTop) {
		[self.cards insertObject:card atIndex:0];
	} else {
		[self.cards addObject:card];
	}
}

- (Card *)drawRandomCard {
    if (self.cards.count > 0 ){
        NSInteger randomCardIndex = arc4random() % [self.cards count];
        Card *randomCard = self.cards[randomCardIndex];
        _countCardsFlipp ++;
        [self.cards removeObjectAtIndex:randomCardIndex];
        return randomCard;
    }
    return nil;
}

@end
