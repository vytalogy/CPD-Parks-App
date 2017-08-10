//
//  InGameScoreView.h
//  CPD
//
//  Created by Tauqeer Ahmed on 7/22/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InGameScoreView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lblScore;

-(void)setUpView;

@end
