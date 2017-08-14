//
//  BonusPointsView.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/26/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BonusPointsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblNumberView;

@property (weak, nonatomic) IBOutlet UILabel *btnContratsView;

-(void)setUpView;
@end
