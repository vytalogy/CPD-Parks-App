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
  

    [self.backImag addShadow];
    
    self.lblHint.font = HintBoldFont;
    
    self.lblDetail.font = RulesRegularTextFont;
    
    
}
-(void)setupForThreeButtons{
    
    //
    [self.backImag addShadow];
    
    
    self.btnFirstPark.layer.cornerRadius = 15;
       self.btnSecondPark.layer.cornerRadius = 15;
        self.btnThridPark.layer.cornerRadius = 15;
}

@end
