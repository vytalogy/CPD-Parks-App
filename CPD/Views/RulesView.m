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
    
    
    
    self.backGroundImage.image = [UIImage imageNamed:@"ready-to-request-black-bg"];
    
    
    self.btnGetStarted.layer.cornerRadius = 15;
    
    
}


@end
