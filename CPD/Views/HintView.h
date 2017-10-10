//
//  HintView.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/23/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HintView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblHint;
@property (weak, nonatomic) IBOutlet UIButton *btnCross;

@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
-(void)setupView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIImageView *backImag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HintHeight;

-(void)setupForThreeButtons;
@property (weak, nonatomic) IBOutlet UIButton *btnFirstPark;
@property (weak, nonatomic) IBOutlet UIButton *btnSecondPark;
@property (weak, nonatomic) IBOutlet UIButton *btnThridPark;

@end
