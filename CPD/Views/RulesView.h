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

@end
