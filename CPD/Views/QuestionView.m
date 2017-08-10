//
//  QuestionView.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/23/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "QuestionView.h"

@implementation QuestionView



-(void)setUpView{
    

    double totalSize = self.frame.size.width;
    
    totalSize = totalSize - 20;
    
    
    
    
    
    
    for (int i = 1; i < 16; i++)
    {
    
        //27  43
        
        

        UIView *currentView = [UIView new];
        
        
        [currentView setFrame:CGRectMake((i * (totalSize/15))-5, 15, 10, 4)];
        
        [currentView setBackgroundColor:[UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
        currentView.layer.cornerRadius = 2;
        
        [self addSubview:currentView];
        
        
        if (self.questionNumber == 1 && i == 1)
        {
            
            UIImageView *currentNumberImage = [UIImageView new];
            [currentNumberImage setImage:[UIImage imageNamed:@"marker"]];
            [currentNumberImage setFrame:CGRectMake(currentView.frame.origin.x-9, -31, 27, 43)];
            [self addSubview:currentNumberImage];
            
            
            
            self.currentNumber = [UILabel new];
            self.currentNumber.font = [UIFont fontWithName:@"RobotoSlab-Bold" size:19];
            [self.currentNumber setFrame:CGRectMake(currentView.frame.origin.x-7,
                                                    -27, 25, 19)];
            ///currentNumber.backgroundColor = [UIColor blueColor];
            self.currentNumber.text = @"1";
            self.currentNumber.textColor = [UIColor blackColor];
            self.currentNumber.textAlignment = NSTextAlignmentCenter;
            
            
            [self addSubview:self.currentNumber];
            
            
        }
        else if (self.questionNumber == 2 && i == 2){
            
            
            UIImageView *currentNumberImage = [UIImageView new];
            [currentNumberImage setImage:[UIImage imageNamed:@"marker"]];
            [currentNumberImage setFrame:CGRectMake(currentView.frame.origin.x-9, -31, 27, 43)];
            [self addSubview:currentNumberImage];
            
            
            
            self.currentNumber = [UILabel new];
            self.currentNumber.font = [UIFont fontWithName:@"RobotoSlab-Bold" size:19];
            [self.currentNumber setFrame:CGRectMake(currentView.frame.origin.x-7,
                                                    -27, 25, 19)];
            ///currentNumber.backgroundColor = [UIColor blueColor];
            self.currentNumber.text = @"2";
            self.currentNumber.textColor = [UIColor blackColor];
            self.currentNumber.textAlignment = NSTextAlignmentCenter;
            
            
            [self addSubview:self.currentNumber];
        }

        else if (self.questionNumber == i){
            
            
            UIImageView *currentNumberImage = [UIImageView new];
            [currentNumberImage setImage:[UIImage imageNamed:@"marker"]];
            [currentNumberImage setFrame:CGRectMake(currentView.frame.origin.x-9, -31, 27, 43)];
            [self addSubview:currentNumberImage];
            
            
            
            self.currentNumber = [UILabel new];
            self.currentNumber.font = [UIFont fontWithName:@"RobotoSlab-Bold" size:19];
            [self.currentNumber setFrame:CGRectMake(currentView.frame.origin.x-7,
                                                    -27, 25, 19)];

            self.currentNumber.text = [NSString stringWithFormat:@"%d",self.questionNumber];
            self.currentNumber.textColor = [UIColor blackColor];
            self.currentNumber.textAlignment = NSTextAlignmentCenter;
            
            
            
            [self addSubview:self.currentNumber];
        }
        
        
        
        
        
        
        
    }
}

@end
