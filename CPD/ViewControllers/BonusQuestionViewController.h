//
//  BonusQuestionViewController.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/23/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionViewController;

@interface BonusQuestionViewController : BaseViewController

@property (nonatomic) BOOL isQuestion2;

@property (nonatomic,strong) Question * questionDoingOn;


@property (nonatomic,strong) QuestionViewController *questionViewController;


@property (nonatomic) BOOL isThingLastQuestion;

@property (nonatomic) int currentScore;

@property (nonatomic,strong) Bonus * bonusItem;

@property (nonatomic) BOOL skipping;


@property (nonatomic,strong) Parks *currentPark;

@end
