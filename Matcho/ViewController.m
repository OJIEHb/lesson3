//
//  ViewController.m
//  Matcho
//
//  Created by Anton Lookin on 10/19/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "PlayingCardDeck.h"

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) PlayingCardDeck *deck;

@property (weak, nonatomic) IBOutlet UILabel *countFlipCards;

@property (weak, nonatomic) IBOutlet UIButton *cardButton;

@property (nonatomic, strong) Card *currentCard;

@end

@implementation ViewController

- (PlayingCardDeck *)deck {
	if (!_deck) {
		_deck = [[PlayingCardDeck alloc] init];
        Card *card1 = [[Card alloc]init];
        Card *card2 = [[Card alloc]init];
        card1.contents = @"10♥";
        card1.contents = @"15♦";
        [_deck addCard:card1];
        [_deck addCard:card2];
	}
	return _deck;
}

- (IBAction)cardButtonShowLog:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        NSLog(@"Card was flipped");
    }
    else{
        _currentCard = [self.deck drawRandomCard];
        if(_currentCard){
            if (([_currentCard class] == [Card class])){
                NSLog(@"Drawed card 666");
            }
            else{
                NSLog(@"Drawed playing card %@", _currentCard.contents);
            }
        }else{
            NSLog(@"Deck is empty");
        }
    }
}

- (IBAction)cardButtonTapped:(UIButton *)sender {
	if ([sender.currentTitle length]) {
		[sender setTitle:@"" forState:UIControlStateNormal];
		[sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
	} else {
        if(_currentCard){
            self.countFlipCards.text = [NSString stringWithFormat:@"%li", (long)[self.deck getCountFlippedCards]];
            [sender setTitle:_currentCard.contents forState:UIControlStateNormal];
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]forState:UIControlStateNormal];
            if (([_currentCard class] == [Card class])){
                [sender setTitleColor: [UIColor grayColor]forState:UIControlStateNormal];
            }
            else{
                if ([_currentCard.contents hasSuffix:@"♦"] || [_currentCard.contents hasSuffix:@"♥"]) {
                    [sender setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
                }
                else{
                    [sender setTitleColor: [UIColor blackColor]forState:UIControlStateNormal];
                }
            }
        }
    }
}

@end
