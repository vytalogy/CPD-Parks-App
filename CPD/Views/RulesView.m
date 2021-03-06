//
//  RulesView.m
//  CDP
//
//  Created by Tauqeer Ahmed on 8/13/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "RulesView.h"
#import "UIView+MyUIView.h"

@implementation RulesView

-(void)setUpView{
    
    


    [self.rulesContainer addShadow];
    
    
    /*self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = CGSize.zero
    self.layer.shadowRadius = 2
    self.layer.cornerRadius = 2*/
    
    

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
    else if(IS_IPad) {
        
        
        self.labelHeightTop.constant = 35;
        
        self.distanceBetween.constant = 0;
        
        self.lblRules.font = [UIFont fontWithName:self.lblRules.font.fontName size:self.lblRules.font.pointSize-6];
        
        self.lblTitle.font = [UIFont fontWithName:self.lblTitle.font.fontName size:self.lblTitle.font.pointSize-7];
        
        
        
    }
    self.backGroundImage.image = [UIImage imageNamed:@"ready-to-request-black-bg"];
    
    
    self.btnGetStarted.layer.cornerRadius = 15;
    
    
    
}


@end
