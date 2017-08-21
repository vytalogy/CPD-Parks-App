//
//  WarningLeaving.m
//  CDP
//
//  Created by Tauqeer Ahmed on 8/21/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "WarningLeaving.h"

@interface WarningLeaving()
@property (weak, nonatomic) IBOutlet UILabel *lblExclaim;
@property (weak, nonatomic) IBOutlet UILabel *lblMEssage;


@property (nonatomic) NSAttributedString *requestText;


@end

@implementation WarningLeaving

-(void)setupView{
    
    self.lblMEssage.attributedText = self.requestText;
    
    
    self.btnExit.layer.cornerRadius = 18;
    self.btnExit.titleLabel.font = [UIFont fontWithName:FontToUseBold size:25];
   
    
    
}


-(NSAttributedString *)requestText{
    
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"You are about to exit request.\nThis will cause you yo lose any points\nfrom unfinished quizzes.\n\nAre you sure you to exit?"];
    id boldFontName = [UIFont fontWithName:FontToUseBold size:20];
    id normalFont = [UIFont fontWithName:FontToUserMedium size:18];
    
    [attrString beginEditing];
    NSRange normalRange2 = NSMakeRange(0, 24);
    
    NSRange boldedRange = NSMakeRange(24, 5);

    NSRange normalRange3 = NSMakeRange(30, 64);
    
    NSRange normalRange4 = NSMakeRange(96, 25);
    
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:boldedRange];
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange2];
    
    
    [attrString addAttribute:kCTFontAttributeName
                       value:normalFont
                       range:normalRange3];
    
    
    [attrString addAttribute:kCTFontAttributeName
                       value:boldFontName
                       range:normalRange4];
    
    
    [attrString endEditing];
    
    return attrString;
    
}

@end
