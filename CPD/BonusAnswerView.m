//
//  BonusAnswerView.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/24/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "BonusAnswerView.h"

@interface BonusAnswerView()

@property (weak, nonatomic) IBOutlet UIView *viewTxtContainer;


@end

@implementation BonusAnswerView


-(void)layoutSubviews {
   
    
}


-(void)setupView{
    
    self.items = [NSMutableArray new];
    
    self.viewTxtContainer.backgroundColor = [UIColor clearColor];
    
    
    int numberOfTextBox = 5;
    
    
    double number = self.viewTxtContainer.frame.size.width/5.0;
    double m = self.viewTxtContainer.frame.size.width;
    
 
    double frame = 55/5.0;
    
    for (int i = 0 ; i < 5 ; i++)
    {
        double CurrentFrame = frame + (number * i);
        
        UITextField *currentTextField = [UITextField new];
        
        [currentTextField setFrame:CGRectMake(CurrentFrame,
                                              0,
                                              55,
                                              55)];
        
        currentTextField.backgroundColor = [UIColor whiteColor];
        
        
        currentTextField.font = [UIFont fontWithName:@"RobotoSlab-Bold" size:30];
        currentTextField.textAlignment = NSTextAlignmentCenter;
        currentTextField.tag = i;
        

        [self.items addObject:currentTextField];
        
        [self.viewTxtContainer addSubview:currentTextField];
    }



    
}
@end
