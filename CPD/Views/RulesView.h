//
//  RulesView.h
//  CDP
//
//  Created by Tauqeer Ahmed on 8/13/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RulesView : UIView
-(void)setUpView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UILabel *lblRules;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;
@property (weak, nonatomic) IBOutlet UIButton *btnGetStarted;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceBetween;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeightTop;
@property (weak, nonatomic) IBOutlet UIView *rulesContainer;

@end
