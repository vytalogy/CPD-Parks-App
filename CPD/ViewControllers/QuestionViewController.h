//
//  QuestionViewController.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : BaseViewController

@property (nonatomic,strong) NSString *viewTitle;

@property (nonatomic) int isQuestion2;

@property (nonatomic,strong) Level *levelSelected;

@property (nonatomic,strong) Parks *parkSelected;


@property (nonatomic,strong) NSMutableArray <Question *>* allQuestion;

@property (nonatomic) BOOL startingQuiz;

@property (nonatomic) int questionIndex;


-(void)setupViewNextQuestion;

@end
