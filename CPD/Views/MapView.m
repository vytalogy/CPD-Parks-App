//
//  MapView.m
//  CDP
//
//  Created by Tauqeer Ahmed on 8/13/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "MapView.h"

@implementation MapView

-(void)setUpView{
    
    
    self.lblText.font = MapRegularTextFont;
    
    
    self.lblAreYouSure.font = MapBoldTextFont;
    
    
    self.btnExit.titleLabel.font = QuestionViewBottomButtonFonts;
    

    
    _btnExit.layer.cornerRadius = 15;
    
    
}

@end
