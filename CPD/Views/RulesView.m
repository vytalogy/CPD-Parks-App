//
//  RulesView.m
//  CDP
//
//  Created by Tauqeer Ahmed on 8/13/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "RulesView.h"

@implementation RulesView

-(void)setUpView{
    
    
    

   self.lblTitle.font = RulesBoldTextFont;
    self.lblTitle.text = @"Ready to request through the Southeast Side Natural Areas?";
    
   self.lblRules.font = RulesRegularTextFont;
    
    self.btnGetStarted.backgroundColor = LightGreenTextColor;
    
    
    if (IS_IPHONE_6) {
   
        self.lblRules.font = [UIFont fontWithName:self.lblRules.font.fontName size:self.lblRules.font.pointSize-1];
        
        self.lblTitle.font = [UIFont fontWithName:self.lblTitle.font.fontName size:self.lblTitle.font.pointSize-2];
        
    }
    else if(IS_IPHONE_5) {
        
        self.lblRules.font = [UIFont fontWithName:self.lblRules.font.fontName size:self.lblRules.font.pointSize-4];
        
        self.lblTitle.font = [UIFont fontWithName:self.lblTitle.font.fontName size:self.lblTitle.font.pointSize-5];
        
        
        
    }
    self.backGroundImage.image = [UIImage imageNamed:@"ready-to-request-black-bg"];
    
    
    self.btnGetStarted.layer.cornerRadius = 15;
    
    
    
}


@end
