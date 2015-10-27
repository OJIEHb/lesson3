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

@property (nonatomic) NSInteger pair;
@property (nonatomic) NSInteger score;
@property (nonatomic, strong) PlayingCardDeck *deck;
@property (nonatomic, strong) Card *currentCard;
@property (nonatomic, strong) NSMutableArray *chosenCard;
@property (weak, nonatomic) IBOutlet UILabel *endGame;
@property (weak, nonatomic) IBOutlet UILabel *countFlippedCards;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSMutableArray *cardButtons;

@end

@implementation ViewController

- (PlayingCardDeck *)deck {
	if (!_deck) {
        _score = 0;
		_deck = [[PlayingCardDeck alloc] init];
        _chosenCard = [[NSMutableArray alloc]init];
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
            NSLog(@"%@",_currentCard);
        }
        else{
            NSLog(@"Deck is empty");
            self.endGame.text = [NSString stringWithFormat:@"Game over"];
        }
    }
}

- (IBAction)cardButtonTapped:(UIButton *)sender {
    
    if([_chosenCard count] > 1){
        [_chosenCard removeAllObjects];
        for(UIButton *button in _cardButtons){
            if([button.currentTitle length] && button.enabled){
                [button setTitle:@"" forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
                NSLog(@"Card flipped %d", button.tag);
            }
        }
    }
	if ([sender.currentTitle length]) {
		[sender setTitle:@"" forState:UIControlStateNormal];
		[sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
	}
    else {
        if(_currentCard){
            self.countFlippedCards.text = [NSString stringWithFormat:@"Count flipped cards : %li", (long)[self.deck getCountFlippedCards]];
            [sender setTitle:_currentCard.contents forState:UIControlStateNormal];
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]forState:UIControlStateNormal];
            [sender setTitleColor:_currentCard.color forState:UIControlStateNormal];
        }
    }
    if ([_chosenCard count] > 0){
        _score += [_currentCard match:_chosenCard];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score : %li", (long)_score];
        if([_currentCard match:_chosenCard] > 0){
            for(UIButton *button in _cardButtons){
                if([button.currentTitle length]){
                    button.enabled = NO;
                    NSLog(@"Card disabled %d",button.tag);
                }
            }
            _pair++;
            if(_pair == 8){self.endGame.text = [NSString stringWithFormat:@"You win"];}
        }
    }
    if(_currentCard){
        [_chosenCard addObject:_currentCard];
    }
}

@end
