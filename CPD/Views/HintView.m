//
//  HintView.m
//  CPD
//
//  Created by Tauqeer Ahmed on 7/23/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "HintView.h"
#import "Config.h"

@implementation HintView



-(void)setupView{
  
    
    self.lblHint.font = HintBoldFont;
    
    self.lblDetail.font = RulesRegularTextFont;
    
    
    /*
     HintBoldFont [UIFont fontWithName:FontToUseRegular size:30]
     #define HintRegularFont [UIFont fontWithName:FontToUseBold size:18]

     */
    
}

@end
