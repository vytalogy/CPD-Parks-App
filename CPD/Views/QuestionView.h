//
//  QuestionView.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/23/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionView : UIView
-(void)setUpView;

@property (nonatomic,strong) UILabel *currentNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionText;

@property (nonatomic) int questionNumber;

@end
