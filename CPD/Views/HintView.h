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

@end
